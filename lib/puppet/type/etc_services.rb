# Manages services entries in /etc/services
#
# Copyright (c) 2014 IN2P3 Computing Centre, IN2P3, CNRS
# Contributor: Remi Ferrand <remi.ferrand_at_cc(dot)in2p3(dot)fr>
# Licensed under the Apache License, Version 2.0

Puppet::Type.newtype(:etc_services) do
  @doc = "Manages services in /etc/services."

  ensurable

  newparam(:name) do
    desc "The name of the service (case sensitive), e.g. remctl"
    isnamevar
  end

  newproperty(:port) do
    desc "The port number (in decimal) to use for this service"
  end

  newproperty(:protocol) do
    desc "The type of protocol to be used"
  end

   newproperty(:aliases, :array_matching => :all) do
     desc "Optional list of other names for this service"
   end

  newproperty(:comment) do
    desc "A comment for this service"
  end

  newparam(:target) do
    desc "The file in which to store services, defaults to
      `/etc/services`."
  end

  autorequire(:file) do
    self[:target]
  end
end
