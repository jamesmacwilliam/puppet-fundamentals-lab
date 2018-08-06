default['chef-ruby']['source']['version'] = '2.5.1'
default['chef-ruby']['source']['checksum'] = 'dac81822325b79c3ba9532b048c2123357d3310b2b40024202f360251d9829b1'
default['chef-ruby']['source']['dependencies'] = []

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
