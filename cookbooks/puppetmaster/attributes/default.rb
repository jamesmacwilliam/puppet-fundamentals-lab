default['puppetmaster']['rhel_repo'] = 'http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm'
default['puppetmaster']['deb_repo'] = 'https://apt.puppetlabs.com/puppetlabs-release-trusty.deb'

default['puppetmaster']['repo'] = if node[:platform_family].include?('rhel')
                                    node['puppetmaster']['rhel_repo']
                                  else
                                    node['puppetmaster']['deb_repo']
                                  end

default['puppetmaster']['selinux'] = 'permissive'
default['puppetmaster']['dns_alt_names'] = %w[puppet puppetmaster puppetmaster.jmac.com]
default['puppetmaster']['environments'] = %w[production]
default['puppetmaster']['deps'] = %w[
  git
  ntp
  mod_ssl
  gcc
  gcc-c++
  libcurl-devel
  openssl-devel
  httpd
  httpd-devel
  ruby-devel
  rubygems
  libcurl-devel
  zlib-devel
]
