include_recipe 'puppetmaster::dependencies'

gem_package 'rack' do
  version '1.6.4'
end

gem_package 'passenger' do
  version '5.0.10'
  options '--conservative'
end

execute 'install passenger' do
  command '/usr/local/bin/passenger-install-apache2-module --languages ruby --auto'
  user 'root'
  not_if { ::File.exist? '/etc/httpd/conf.d/puppetmaster.conf' }
end

[
  'mkdir -p /usr/share/puppet/rack/puppetmasterd/{public,tmp}',
  'cp /usr/share/puppet/ext/rack/config.ru /usr/share/puppet/rack/puppetmasterd',
  'chown puppet:puppet /usr/share/puppet/rack/puppetmasterd/config.ru',
  'chown puppet:puppet /etc/puppet',
  'chmod -R 0777 /etc/puppet'
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

execute 'add snippet to temp file Note: use latest ruby for passenger but let it run apps in 2.0' do
  command '/usr/local/bin/passenger-install-apache2-module --snippet > snippet 2>&1'
  user 'root'
end

execute 'set puppetmaster.conf snippet replacement' do
  command %q{ruby -e "path = '/etc/httpd/conf.d/puppetmaster.conf'; IO.write(path, File.open(path) {|f| f.read.gsub('SNIPPET', File.read('snippet')) })"}
  user 'root'
end

service 'httpd' do
  action :start
end
