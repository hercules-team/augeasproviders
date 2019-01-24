[![Puppet Forge](http://img.shields.io/puppetforge/v/herculesteam/augeasproviders.svg)](https://forge.puppetlabs.com/herculesteam/augeasproviders)
[![Build Status](https://travis-ci.org/hercules-team/augeasproviders.svg?branch=master)](https://travis-ci.org/hercules-team/augeasproviders)
[![Coverage Status](https://img.shields.io/coveralls/hercules-team/augeasproviders.svg)](https://coveralls.io/r/hercules-team/augeasproviders?branch=master)

# augeasproviders: alternative Augeas-based providers for Puppet

This module provides is a meta module which gathers all official augeasproviders
modules as dependencies. 
Augeasproviders modules provide alternative Augeas-based providers for Puppet
providers around config files, using the Augeas configuration library to read
and modify them.

The advantage of using Augeas over the default Puppet `parsedfile`
implementations is that Augeas will go to great lengths to preserve file
formatting and comments, while also failing safely when needed.

## Requirements

Ensure both Augeas and ruby-augeas 0.3.0+ bindings are installed and working as
normal.

See [Puppet/Augeas pre-requisites](http://docs.puppetlabs.com/guides/augeas.html#pre-requisites).

## Classes

### augeasproviders::instances

This class allows the types provided by this module to be defined using the classes' parameters or top-scope variables.

**NOTE**: The classes' parameters take presedence over the top-scope variables.

Set the sysctl entry *net.ipv4.ip_forward* to *1*:

    class { 'augeasproviders::instances':
      sysctl_hash => { 'net.ipv4.ip_forward' => { 'value' => '1' } },
    }

The following example is the same as above but using a top-scope variable.

    node 'foo.example.com' {
      $augeasproviders_sysctl_hash = {
        'net.ipv4.ip_forward' => { 'value' => '1' },
      }
      
      include augeasproviders::instances
    }

#### Parameters

#####`TYPE`_hash

All types have a `TYPE`_hash parameter, where `TYPE` is the resource type.  These parameters accept a Hash to define that type's resources.

#####`resource_defaults`

A Hash that contains the default values used to create each resource.  See *manifests/params.pp* for the format used.

#### Variables

#####augeasproviders\_`TYPE`\_hash

All types have a augeasproviders\_`TYPE`\_hash variable, where `TYPE` is the resource type.  These variables accept a Hash to define that type's resources.

## Development documentation

See docs/ (run `make`) or [augeasproviders.com](http://augeasproviders.com/documentation/).

## Issues

Please file any issues or suggestions [on GitHub](https://github.com/hercules-team/augeasproviders/issues).
