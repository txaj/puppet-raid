class raid::service (
    $service = $raid::params::service
    ) inherits raid::params {

    case $::raid_service {
      /^(running|true)$/,undef,default: {
          $raid_service_ensure = 'running'
          $raid_service_enable = true
      }
      /^(stopped|false)$/: {
          $raid_service_ensure = 'stopped'
          $raid_service_enable = false
      }
    }

    $raid_mailto = $::raid_mailto ? {
          undef => undef,
          default => "set MAILTO ${::raid_mailto}"
    }

    $raid_period = $::raid_period ? {
          undef => undef,
          default => "set PERIOD ${::raid_period}"
    }

    $raid_remind = $::raid_remind ? {
          undef => undef,
          default => "set REMIND ${::raid_remind}"
    }

    service { $service:
        ensure => $raid_service_ensure,
        enable => $raid_service_enable
    }

    file { '/etc/default/${service}':
      ensure => present
    }

    augeas { 'set_defaults':
      context => "/files/etc/default/${service}",
      changes => [ $raid_mailto, $raid_period, $raid_remind ],
      require => File['/etc/default/${service}']
    }

}
