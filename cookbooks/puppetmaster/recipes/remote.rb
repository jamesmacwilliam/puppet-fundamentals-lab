execute 'add puppetmaster host' do
  command 'echo 172.31.0.201 puppetmaster >> /etc/hosts'
  user 'root'
  not_if 'grep puppetmaster /etc/hosts'
end

if node[:platform_family].include?('rhel')
  installer = :package
  local = "puppet.rpm"
else
  installer = :dpkg_package
  local = "puppet"
end

remote_file "#{Chef::Config[:file_cache_path]}/#{local}" do
  source node['puppetmaster']['repo']
  action :create
end

send(installer, 'puppet') do
  source "#{Chef::Config[:file_cache_path]}/#{local}"
  action :install
end
