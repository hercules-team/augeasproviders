# Alternative Augeas-based provider for /etc/services type
#
# Copyright (c) 2014 IN2P3 Computing Centre, IN2P3, CNRS
# Contributor: Remi Ferrand <remi.ferrand_at_cc(dot)in2p3(dot)fr>
# Licensed under the Apache License, Version 2.0

Puppet::Type.type(:etc_services).provide(:augeas, :parent => Puppet::Type.type(:augeasprovider).provider(:default)) do
  desc "Uses Augeas API to update services entries."

  default_file { '/etc/services' }

  lens { 'Services.lns' }

  confine :feature => :augeas

  resource_path do |resource|
    "$target/service-name[. = '#{resource[:name]}'][protocol = '#{resource[:protocol]}']"
  end

  def self.get_aliases(aug, path)
    aliases = []
    aug.match("#{path}/alias").map do |apath|
      aliases << aug.get(apath)
    end
    return aliases
  end

  def self.instances

    augopen do |aug|
      resources = []
      aug.match("/files/etc/services/service-name[*]").map do |spath|
        protocol = aug.get("#{spath}/protocol")
        port = aug.get("#{spath}/port")
        comment = aug.get("#{spath}/comment")

        entry = {
            :ensure     => :present,
            :name       => aug.get(spath),
            :port       => port,
            :protocol   => protocol,
            :aliases    => self.class.get_aliases(aug, spath),
            :comment    => comment
        }

        resources << new(entry)
      end
      resources
    end
  end

  define_aug_method!(:create) do |aug, resource|
    aug.defnode('resource', resource_path(resource), resource[:name])
    aug.set('$resource/port', resource[:port])
    aug.set('$resource/protocol', resource[:protocol])

    #Note(remi)
    # aliases MUST be set before #comment
    if resource[:aliases].is_a? Array
      resource[:aliases].each do |thealias|
        aug.set("$resource/alias[.='#{thealias}']", thealias)
      end
    else
      aug.set('$resource/alias', resource[:aliases])
    end

    aug.set('$resource/#comment', resource[:comment])
  end

  define_aug_method!(:destroy) do |aug, resource|
    aug.rm(resource_path(resource))
  end

  def port()
    augopen do |aug|
      aug.get('$resource/port')
    end
  end

  def port=(value)
    augopen do |aug|
      aug.set('$resource/port', value)
    end
  end

  def protocol()
    augopen do |aug|
      aug.get('$resource/protocol')
    end
  end

  def protocol=(value)
    augopen do |aug|
      aug.set('$resource/protocol', value)
    end
  end

  def comment()
    augopen do |aug|
      aug.get('$resource/#comment')
    end
  end

  def comment=(value)
    augopen do |aug|
      if value.empty?
        aug.rm('$resource/#comment')
      else
        aug.set('$resource/#comment', value)
      end
    end
  end

  def aliases()
    aliases = []
    augopen do |aug| 
      aliases = self.class.get_aliases(aug, '$resource')
    end

    return aliases
  end

  def aliases=(value)
    augopen do |aug| 
      aug.rm('$resource/alias')
      aug.rm('$resource/#comment')
      if value.is_a? Array
        value.each do |v|
          aug.set("$resource/alias[.='#{v}']", v)
        end
      else
        aug.set('$resource/alias', v)
      end

      self.comment=(resource.should(:comment))
    end
  end

  attr_aug_accessor(:name, :label => :resource)
end
