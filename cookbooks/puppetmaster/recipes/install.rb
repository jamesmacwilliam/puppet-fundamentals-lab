include_recipe 'puppetmaster::dependencies'
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

template '/etc/puppet/autosign.conf' do
  source 'autosign.conf.erb'
  owner 'root'
  group 'root'
  mode  '777'
end

%w[puppet autosign].each do |file|
  execute "set security context for #{file}.conf" do
    command "chcon --reference=/etc/puppet/fileserver.conf /etc/puppet/#{file}.conf"
    user 'root'
  end
end

execute 'generate puppet cert' do
  command 'timeout --preserve-status 5 puppet master --no-daemonize --verbose'
  user 'root'
  not_if { ::File.exist?('/var/lib/puppet/ssl/private_keys/puppetmaster.pem') }
end

# note - don't do this on prod, this is a dev only hack
cron 'sign all pending nodes every 12 seconds' do
  minute '*'
  command((['puppet cert sign --all'] * 4).join(' | sleep 10 | '))
  user 'root'
end
