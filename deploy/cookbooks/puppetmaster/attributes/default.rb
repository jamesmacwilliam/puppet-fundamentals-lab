default['puppetmaster']['repo'] = 'http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm'
default['puppetmaster']['selinux'] = 'permissive'
default['puppetmaster']['dns_alt_names'] = %w[puppet puppetmaster puppetmaster.jmac.com]
default['puppetmaster']['deps'] = %w[
  git
  ntp
  httpd
  httpd-devel
  mod_ssl
  gcc
  gcc-c++
  libcurl-devel
  openssl-devel
]
