include_recipe 'puppetmaster::remote'

package 'puppet-agent' do
  action :install
end
