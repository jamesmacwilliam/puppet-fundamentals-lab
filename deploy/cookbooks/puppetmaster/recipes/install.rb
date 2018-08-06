remote_file "#{Chef::Config[:file_cache_path]}/puppet-server.rpm" do
  source node['puppetmaster']['repo']
  action :create
end

rpm_package 'puppet-server' do
  source "#{Chef::Config[:file_cache_path]}/puppet-server.rpm"
  action :install
end
