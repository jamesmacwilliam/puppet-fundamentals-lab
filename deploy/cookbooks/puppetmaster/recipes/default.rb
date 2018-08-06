#
# Cookbook:: puppetmaster
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'puppetmaster::dependencies'
include_recipe 'puppetmaster::firewall'
include_recipe 'puppetmaster::install'
# commenting out newest ruby for now since it is conflicting with puppet
#include_recipe 'chef-ruby::default'
