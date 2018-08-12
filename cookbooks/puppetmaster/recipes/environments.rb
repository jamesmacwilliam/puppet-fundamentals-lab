package 'git'

execute 'purge environments' do
  command 'rm -rf /etc/puppetlabs/code/environments'
  user 'root'
end

git 'remote - environments' do
  repository "https://github.com/#{node['puppetmaster']['environments_git_repo']}.git"
  revision 'master'
  destination '/etc/puppetlabs/code/environments'
  user 'root'
  action :sync
end

cron 'poll git repo every minute' do
  minute '*'
  command 'cd /etc/puppetlabs/code/environments && git fetch origin && git reset --hard origin/master'
  user 'root'
end
