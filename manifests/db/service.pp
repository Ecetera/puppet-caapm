
class caapm::db::service inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $notify_enabled {
    notify {"Running with db::service pg_as_service = $pg_as_service":}
  }

  case $::operatingsystem {
    CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {

      if $pg_as_service {

        # generate the SystemV init script
        file { $pg_service_name:
          ensure  => present,
          force   => true,
          path    => "/etc/init.d/${pg_service_name}",
          content => template("${module_name}/init.d/postgresql"),
          owner   =>  'root',
          group   =>  'root',
          mode    =>  '0755',
          notify  => Service[$pg_service_name],
        }

        file { "${postgres_dir}/data/postgresql.conf":
          owner   =>  $owner,
          group   =>  $group,
          mode    =>  $mode,
        }

        file { "${postgres_dir}/data/pg_hba.conf":
          owner   =>  $owner,
          group   =>  $group,
          mode    =>  $mode,
        }
      }
    }
    windows: {

    }
    default: {}

  }

  service { $pg_service_name:
    ensure => $pg_as_service,
    enable => $pg_as_service,
    subscribe => [File["${postgres_dir}/data/pg_hba.conf"],File["${postgres_dir}/data/postgresql.conf"]]
  }

}
