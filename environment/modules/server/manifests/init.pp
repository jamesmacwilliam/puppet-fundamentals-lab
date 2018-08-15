class server {
  package { 'puppetserver':
    ensure => 'installed'
  }

  File_line {
    path  => '/etc/puppetlabs/puppet/puppet.conf',
    after => 'master'
  }

  file_line { 'certname':
    match => 'certname',
    line  => 'certname = puppetmaster'
  }

  file_line { 'environment':
    match => 'environment',
    line  => 'environment = production'
  }

  file_line { 'runinterval':
    match => 'runinterval',
    line  => 'runinterval = 1h'
  }

  file_line { 'autosign':
    match => 'autosign',
    line  => 'autosign = true'
  }

  file_line { 'dns_alt_names':
    match => 'dns_alt_names',
    line  => 'dns_alt_names = puppet,puppetmaster'
  }

  service { 'puppetserver':
    enable => true,
    ensure => 'running'
  }
}
