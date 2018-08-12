default['puppetmaster']['environments_git_repo'] = 'jamesmacwilliam/puppet-lab-conf'
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
default['puppetmaster']['rhel_deps'] = %w[
  git
  ntp
  gcc
  libcurl-devel
  openssl-devel
  httpd
  httpd-devel
  ruby-devel
  rubygems
  libcurl-devel
  zlib-devel
  rubygems
  gcc-c++
  mod_ssl
]
default['puppetmaster']['deb_deps'] = %w[
  git
  ntp
  gcc
  openssl
  apache2
  ruby-dev
  zlib1g-dev
  g++
  libcurl4-openssl-dev
]

default['puppetmaster']['deps'] = if node[:platform_family].include?('rhel')
                                    default['puppetmaster']['rhel_deps']
                                  else
                                    default['puppetmaster']['deb_deps']
                                  end
