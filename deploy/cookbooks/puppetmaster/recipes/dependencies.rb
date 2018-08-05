yum_repository 'puppet repo' do
  baseurl node['puppetmaster']['repo']
  action :create
end

remote_file "#{Chef::Config[:file_cache_path]}/puppet-server.rpm" do
  source node['puppetmaster']['repo']
  action :create
end

node['puppetmaster']['deps'].each { |pkg| package pkg }

rpm_package 'puppet-server' do
  source "#{Chef::Config[:file_cache_path]}/puppet-server.rpm"
  action :install
end
