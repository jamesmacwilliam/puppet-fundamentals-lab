%w[httpd httpd-devel].each { |pkg| package pkg }

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

template '/etc/httpd/conf.d/puppetmaster.conf' do
  source 'puppetmaster.conf.erb'
  owner 'root'
  group 'root'
  mode  '777'
end

rbenv_script 'add snippet to temp file' do
  rbenv_version node['puppetmaster']['passenger_ruby']
  code 'passenger-install-apache2-module --snippet > snippet 2>&1'
  user 'root'
end

rbenv_script 'set puppetmaster.conf snippet replacement' do
  rbenv_version node['puppetmaster']['passenger_ruby']
  code %Q{ruby -e "path = '/etc/httpd/conf.d/puppetmaster.conf'; IO.write(path, File.open(path) {|f| f.read.gsub('SNIPPET', File.read('snippet')) })"}
  user 'root'
end

service 'httpd' do
  action :start
end
