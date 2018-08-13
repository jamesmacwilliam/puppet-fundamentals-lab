include_recipe 'puppetmaster::remote'

package 'puppet-agent' do
  action :install
end

template '/etc/puppetlabs/puppet/puppet.conf' do
  source 'agent.conf.erb'
  owner 'root'
  group 'root'
  mode  '777'
end

execute "set security context for puppet.conf" do
  command "chcon --reference=/etc/puppetlabs/puppet/auth.conf /etc/puppetlabs/puppet/puppet.conf"
  user 'root'
end

execute 'start and enable puppet agent' do
  command 'puppet resource service puppet ensure=running enable=true'
  cwd '/opt/puppetlabs/bin'
  user 'root'
end
