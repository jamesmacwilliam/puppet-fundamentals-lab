default['puppetmaster']['passenger_ruby'] = '2.5.1'
default['puppetmaster']['repo'] = 'http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm'
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
]
