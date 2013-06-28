# Alternative Augeas-based providers for Puppet
#
# Copyright (c) 2012 Raphaël Pinson
# Licensed under the Apache License, Version 2.0

require File.dirname(__FILE__) + '/../../../augeasproviders/provider'

Puppet::Type.type(:syslog).provide(:augeas) do
  desc "Uses Augeas API to update a syslog.conf entry"

  include AugeasProviders::Provider

  default_file { '/etc/syslog.conf' }

  lens do |resource|
    if resource and resource[:lens]
      resource[:lens]
    else
      'Syslog.lns'
    end
  end

  confine :feature => :augeas
  confine :exists => target

  resource_path do |resource|
    entry_path(resource)
  end

  def self.entry_path(resource)
    path = "/files#{self.target(resource)}"
    facility = resource[:facility]
    level = resource[:level]
    action_type = resource[:action_type]
    action = resource[:action]

    # TODO: make it case-insensitive
    "#{path}/entry[selector/facility='#{facility}' and selector/level='#{level}' and action/#{action_type}='#{action}']"
  end

  def self.path_label(path)
    path.split("/")[-1].split("[")[0]
  end

  def self.get_value(aug, pathx)
    aug.get(pathx)
  end

  def self.instances
    augopen do |aug, path|
      resources = []

      aug.match("#{path}/entry").each do |apath|
        aug.match("#{apath}/selector").each do |snode|
          aug.match("#{snode}/facility").each do |fnode|
            facility = self.get_value(aug, fnode) 
            level = self.get_value(aug, "#{snode}/level")
            no_sync = aug.match("#{apath}/action/no_sync").empty? ? :false : :true
            action_type_node = aug.match("#{apath}/action/*[label() != 'no_sync']")
            action_type = self.path_label(action_type_node[0])
            action = self.get_value(aug, "#{apath}/action/#{action_type}")
            name = "#{facility}.#{level} "
            name += "-" if no_sync == :true
            name += "@" if action_type == "hostname"
            name += "#{action}"
            entry = {:ensure => :present, :name => name,
                     :facility => facility, :level => level,
                     :no_sync => no_sync,
                     :action_type => action_type, :action => action}
            resources << new(entry)
          end
        end
      end

      resources
    end
  end

  def exists? 
    self.class.augopen(resource) do |aug, path|
      entry_path = self.class.resource_path(resource)
      not aug.match(entry_path).empty?
    end
  end

  def create 
    entry_path = self.class.resource_path(resource)
    facility = resource[:facility]
    level = resource[:level]
    no_sync = resource[:no_sync]
    action_type = resource[:action_type]
    action = resource[:action]
    self.class.augopen(resource) do |aug, path|
      # TODO: make it case-insensitive
      aug.set("#{entry_path}/selector/facility", facility)
      aug.set("#{path}/*[last()]/selector/level", level)
      if no_sync == :true and action_type == 'file'
        aug.clear("#{path}/*[last()]/action/no_sync")
      end
      aug.set("#{path}/*[last()]/action/#{action_type}", action)
      augsave!(aug)
    end
  end

  def destroy
    self.class.augopen(resource) do |aug, path|
      entry_path = self.class.resource_path(resource)
      aug.rm(entry_path)
      augsave!(aug)
    end
  end

  def target
    self.class.target(resource)
  end

  def no_sync
    self.class.augopen(resource) do |aug, path|
      entry_path = self.class.resource_path(resource)
      if aug.match("#{entry_path}/action/no_sync").empty?
        :false
      else
        :true
      end
    end
  end

  def no_sync=(no_sync)
    self.class.augopen(resource) do |aug, path|
      entry_path = self.class.resource_path(resource)
      if no_sync == :true
        if aug.match("#{entry_path}/action/no_sync").empty?
          # Insert a no_sync node before the action/file node
          aug.insert("#{entry_path}/action/file", "no_sync", true)
        end
      else
        # Remove the no_sync tag
        aug.rm("#{entry_path}/action/no_sync")
      end
      augsave!(aug)
    end
  end
end
