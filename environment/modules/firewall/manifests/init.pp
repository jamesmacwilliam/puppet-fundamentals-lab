class firewall {
  file_line { 'selinux config':
    path  => '/etc/sysconfig/selinux',
    match => '^SELINUX=',
    line  => 'SELINUX=permissive'
  }

  exec { '/sbin/setenforce Permissive':
    user => 'root'
  }

  package { 'firewalld': }

  service { 'firewalld':
    enable => true,
    ensure => 'running'
  }

  exec { '/usr/bin/firewall-cmd --zone=public --add-port=8140/tcp --permanent':
    user => 'root'
  }
  exec { '/usr/bin/firewall-cmd --reload':
    user => 'root'
  }
}
