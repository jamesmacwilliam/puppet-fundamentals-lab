package 'ntp'

service 'ntpd' do
  action :start
end

include_recipe 'puppetmaster::remote'

yum_package 'puppetserver' do
  action :install
end

template '/etc/puppetlabs/puppet/puppet.conf' do
  source 'puppet.conf.erb'
  owner 'root'
  group 'root'
  mode  '777'
end

#template '/etc/puppetlabs/puppet/autosign.conf' do
  #source 'autosign.conf.erb'
  #owner 'root'
  #group 'root'
  #mode  '777'
#end

execute "set security context for puppet.conf" do
  command "chcon --reference=/etc/puppetlabs/puppet/auth.conf /etc/puppetlabs/puppet/puppet.conf"
  user 'root'
end

systemd_unit 'puppetserver' do
  action [:start, :enable]
end
