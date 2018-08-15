class agent {
  host { 'puppetmaster':
    ip => '172.31.0.201'
  }

  File_line {
    path  => '/etc/puppetlabs/puppet/puppet.conf',
    after => 'main'
  }

  file_line { 'run interval 60 seconds':
    match => 'runinterval',
    line  => 'runinterval = 60s'
  }

  file_line { 'server':
    match => 'server',
    line  => 'server = puppetmaster'
  }

  file_line { 'environment':
    match => 'environment',
    line  => 'environment = production'
  }

  service { 'puppet':
    enable => true,
    ensure => 'running'
  }
}
