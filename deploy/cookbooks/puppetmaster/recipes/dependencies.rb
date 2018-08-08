node['puppetmaster']['deps'].each { |pkg| package pkg }

service 'ntpd' do
  action :start
end
