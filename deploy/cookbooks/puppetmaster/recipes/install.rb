remote_file "#{Chef::Config[:file_cache_path]}/puppet-server.rpm" do
  source node['puppetmaster']['repo']
  action :create
end

rpm_package 'puppet-server' do
  source "#{Chef::Config[:file_cache_path]}/puppet-server.rpm"
  action :install
end

package 'ruby' # puppet relies on this version of ruby
package 'puppet-server'

template '/etc/puppet/puppet.conf' do
  source 'puppet.conf.erb'
  owner 'root'
  group 'root'
  mode  '777'
end

execute 'set security context' do
  command 'chcon --reference=/etc/puppet/fileserver.conf /etc/puppet/puppet.conf'
  user 'root'
end

execute 'generate puppet cert' do
  command 'timeout --preserve-status 5 puppet master --no-daemonize --verbose'
  user 'root'
end
