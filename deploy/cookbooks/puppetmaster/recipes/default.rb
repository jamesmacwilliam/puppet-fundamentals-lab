#
# Cookbook:: puppetmaster
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'puppetmaster::dependencies'
include_recipe 'puppetmaster::firewall'
include_recipe 'puppetmaster::install'
