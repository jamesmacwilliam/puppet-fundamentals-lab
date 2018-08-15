class ntp {
  $ntpservice = $osfamily ? {
    'redhat'        => 'ntpd',
    'debian'    => 'ntp',
    default => 'ntp'
  }

  package { 'ntp':
    ensure => 'installed'
  }

  service { $ntpservice:
    ensure     => 'running',
    enable => true
  }
}
