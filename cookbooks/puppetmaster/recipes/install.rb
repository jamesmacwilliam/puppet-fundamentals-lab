include_recipe 'puppetmaster::remote'

yum_package 'puppet-server' do
  action :install
end

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
  not_if { ::File.directory?('/var/lib/puppet/ssl') }
end
