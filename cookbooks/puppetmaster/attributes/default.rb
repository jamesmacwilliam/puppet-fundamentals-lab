default['puppetmaster']['environments_git_repo'] = 'jamesmacwilliam/puppet-lab-conf'
default['puppetmaster']['rhel_repo'] = 'https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm'
default['puppetmaster']['deb_repo'] = 'https://apt.puppetlabs.com/puppet5-release-trusty.deb'

default['puppetmaster']['repo'] = if node[:platform_family].include?('rhel')
                                    node['puppetmaster']['rhel_repo']
                                  else
                                    node['puppetmaster']['deb_repo']
                                  end

default['puppetmaster']['selinux'] = 'permissive'
