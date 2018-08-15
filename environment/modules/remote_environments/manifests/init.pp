class remote_environments {
  package { 'git': }

  exec { 'rm -rf /etc/puppetlabs/code/environments':
    user => 'root',
    path => '/usr/bin'
  }

  vcsrepo { '/etc/puppetlabs/code/environments':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/jamesmacwilliam/puppet-lab-conf.git',
    user     => 'root'
  }

  cron {'poll git repo every minute':
    command => 'cd /etc/puppetlabs/code/environments && git fetch origin && git reset --hard origin/master',
    user    => 'root',
    minute  => '*'
  }
}
