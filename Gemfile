source :rubygems

if ENV.key?('PUPPET_VERSION')
  puppetversion = "= #{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['>= 2.7']
end

gem 'rake'
gem 'puppet-lint'
gem 'rspec-puppet'
gem 'ruby-augeas'
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper'
gem 'simplecov'
