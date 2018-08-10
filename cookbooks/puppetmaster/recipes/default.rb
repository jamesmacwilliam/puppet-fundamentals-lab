#
# Cookbook:: puppetmaster
# Recipe:: default
#
# Copyright:: 2018, James Mac William, All Rights Reserved.

include_recipe 'puppetmaster::dependencies'
#include_recipe 'puppetmaster::firewall'
include_recipe 'puppetmaster::install'
include_recipe 'puppetmaster::environments'
include_recipe 'puppetmaster::passenger'
