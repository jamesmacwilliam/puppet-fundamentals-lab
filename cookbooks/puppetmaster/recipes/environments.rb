execute 'purge environments' do
  command 'rm -rf /etc/puppet/environments'
  user 'root'
end

git 'remote - environments' do
  repository "https://github.com/#{node['puppetmaster']['environments_git_repo']}.git"
  revision 'master'
  destination '/etc/puppet/environments'
  user 'root'
  action :sync
end

cron 'poll git repo every minute' do
  minute '*'
  command 'cd /etc/puppet/environments && git fetch origin && git reset --hard origin/master'
  user 'root'
end
