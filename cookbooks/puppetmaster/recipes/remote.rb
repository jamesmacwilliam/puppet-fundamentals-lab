execute 'add puppetmaster host' do
  command 'echo 172.31.0.201 puppetmaster >> /etc/hosts'
  user 'root'
  not_if 'grep puppetmaster /etc/hosts'
end

remote_file "#{Chef::Config[:file_cache_path]}/puppet" do
  source node['puppetmaster']['repo']
  action :create
end

package 'ruby' # puppet relies on this version of ruby

installer = node[:platform_family].include?('rhel') ? :package : :dpkg_package

send(installer, 'puppet') do
  source "#{Chef::Config[:file_cache_path]}/puppet"
  action :install
end
