%w[httpd httpd-devel].each { |pkg| package pkg }

service 'httpd' do
  action :start
end

rbenv_system_install 'system'
rbenv_ruby node['puppetmaster']['passenger_ruby']

rbenv_gem 'rack' do
  version '2.0.5'
  rbenv_version node['puppetmaster']['passenger_ruby']
end

rbenv_gem 'passenger' do
  version '5.3.4'
  rbenv_version node['puppetmaster']['passenger_ruby']
end

rbenv_script 'install passenger' do
  rbenv_version node['puppetmaster']['passenger_ruby']
  code 'passenger-install-apache2-module --languages ruby --no-compile --auto'
end

[
  'mkdir -p /usr/share/puppet/rack/puppetmasterd/{public,tmp}',
  'cp /usr/share/puppet/ext/rack/config.ru /usr/share/puppet/rack/puppetmasterd',
  'chown puppet:puppet /usr/share/puppet/rack/puppetmasterd/config.ru'
].each do |cmd|
  execute cmd do
    command cmd
    user 'root'
  end
end

gem_path = "#{`gem env | grep '[-] INSTALLATION' | cut -d ':' -f 2 | awk '{$1=$1};1'`}/gems/passenger-5.3.4"

node.default['puppetmaster']['gem_path'] = gem_path

template '/etc/httpd/conf.d/puppetmaster.conf' do
  source 'puppetmaster.conf.erb'
  owner 'root'
  group 'root'
  mode  '777'
end

rbenv_script 'set puppetmaster.conf snippet replacement' do
  rbenv_version node['puppetmaster']['passenger_ruby']
  code "sed 's/SNIPPET/$(passenger-install-apache2-module --snippet)/g' /etc/httpd/conf.d/puppetmaster.conf"
  user 'root'
end
