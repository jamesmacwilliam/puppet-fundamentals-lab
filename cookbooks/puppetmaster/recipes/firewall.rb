execute 'set SELinux to permissive mode' do
  command 'setenforce permissive'
  user 'root'
end

template '/etc/sysconfig/selinux' do
  source 'selinux.erb'
  owner 'root'
  group 'root'
  mode  '777'
end

package 'firewalld'

%i[start enable].each do |key|
  systemd_unit 'firewalld.service' do
    action key
  end
end

execute 'open port 8140' do
  command 'firewall-cmd --zone=public --add-port=8140/tcp --permanent'
  user 'root'
end

execute 'reload firewall' do
  command 'firewall-cmd --reload'
  user 'root'
end
