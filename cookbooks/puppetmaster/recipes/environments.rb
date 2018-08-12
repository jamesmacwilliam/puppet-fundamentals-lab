execute 'purge environments' do
  command 'rm -rf /etc/puppet/environments'
  user 'root'
end

git 'remote - environments' do
  repository "https://github.com/#{node['puppetmaster']['environments_git_repo']}.git"
  revision 'master'
  destination '/etc/puppet/environments'
  user 'puppet'
  group 'puppet'
  action :sync
end
