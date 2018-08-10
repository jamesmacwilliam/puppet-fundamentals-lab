include_recipe 'puppetmaster::dependencies'
include_recipe 'puppetmaster::remote'

package 'puppet' do
  action :install
end

template '/etc/puppet/puppet.conf' do
  source 'agent.conf.erb'
  owner 'root'
  group 'root'
  mode  '777'
end

execute 'enable puppet' do
  command 'puppet agent --enable'
  user 'root'
end

execute 'generate puppet cert' do
  command 'puppet agent --no-daemonize --verbose --onetime'
  user 'root'
  not_if { ::File.directory?('/var/lib/puppet/ssl') }
end
