get puppet installled:

```
sudo yum -y install vim git ntp
sudo service ntpd start
sudo yum -y install http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
sudo yum -y install puppet-server
puppet master --version
```

 ## Directory Environments (directory per environment on puppet master)

each directory env. is controlled by a conf file.
/etc/puppet/environments/<env-name ie: production>/environment.conf

puppet conf:  /etc/puppet/puppet.conf (1 puppet conf per master)
3 sections: Master/Agent/Main

sample puppet.conf
```
[main]
    logdir = /var/log/puppet
    rundir = /var/run/puppet
    ssldir $vardir/ssl
    dns_alt_names = puppet,puppetmaster

[master]
    environmentpath = $confdir/environments
    basemodulepath = $confdir/modules:/opt/puppet/share/puppet/modules

[agent]
    classfile = $vardir/classes.txt
```

- main can apply to both master and agent
- $confdir is /etc/puppet
- there is an agent block because the puppet master can configure itself using the agent

- get started creating an env `mkdir -p /etc/puppet/environments/production/{modules,manifests}`

- set SELinux to permissive mode
  * `sudo setenforce permissive`
  * `sudo sed -i 's\=enforcing\=permissive\g' /etc/sysconfig/selinux` (enforce across restarts)
  * `sudo getenforce` # should respond with Permissive
- generate cert.
  * `sudo puppet master --verbose --no-daemonize`
  * generates cert if none exists, if we ever want to regen, just rm -rf /var/lib/puppet/ssl

- add firewall rules
- re-enable SELinux (enforcement mode)
`yum install firewalld`
`systemctl start firewald`
`systemctl enable firewald`
`firewall-cmd --zone=public --add-port=8140/tcp --permanent`
`firewall-cmd --reload`
`yum -y install httpd httpd-devel mod_ssl ruby-devel rubygems plural gcc gcc-c++ libcurl-devel openssl-devel` # getting setup to use apache + passenger
 install ruby from source if on CentOS (the default is 2.0 from yum, and that is too low) do not yum remove just add the newer version to PATH
`gem install rack passenger`
run `gem env` and then run `passenger-install-apache2-module` from the bin dir of the passenger gem directory

`sudo mkdir -p /usr/share/puppet/rack/puppetmasterd/{public,tmp}`
`sudo cp /usr/share/puppet/ext/rack/config.ru /usr/share/puppet/rack/puppetmasterd`
`sudo chown puppet:puppet /usr/share/puppet/rack/puppetmasterd/config.ru`
`git clone https://github.com/benpiper/puppet-fundamentals-puppetmaster`
`cd puppet-fundamentals-puppetmaster`
replace the loadmodule line with the output from the passenger install
`sudo cp puppetmaster.conf /etc/httpd/conf.d/`
`sudo service httpd start`

add puppetmaster to both managed nodes host files:
`vagrant ssh`
`sudo -i`
`echo 172.31.0.201 puppetmaster >> /etc/hosts`
