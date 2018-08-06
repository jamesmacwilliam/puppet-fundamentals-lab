yum_repository 'puppet repo' do
  baseurl node['puppetmaster']['repo']
  action :create
end

node['puppetmaster']['deps'].each { |pkg| package pkg }

service 'ntpd' do
  action :start
end
