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

package 'puppet' do
  source "#{Chef::Config[:file_cache_path]}/puppet"
  action :install
end

package 'puppet' do
  action :install
end

template '/etc/puppet/puppet.conf' do
  source 'agent.conf.erb'
  owner 'root'
  group 'root'
  mode  '777'
end

execute 'set security context' do
  command 'chcon --reference=/etc/puppet/auth.conf /etc/puppet/puppet.conf'
  user 'root'
end

execute 'generate puppet cert' do
  command 'puppet agent --no-daemonize --verbose --onetime'
  user 'root'
  not_if { ::File.directory?('/var/lib/puppet/ssl') }
end
