
class caapm::db::service inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

#  notify {"Running with db::service pg_as_service = $pg_as_service":}

  case $::operatingsystem {
    CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {

      if $pg_as_service {
        exec { "set_pg_service_user":

# these conditions were attempts to check before executing a replacement.
#          onlyif  => "/usr/bin/test ! (-f /etc/init.d/${pg_service_name})",
#          onlyif  => "/bin/awk \'/su - ${owner} -c/ {print;}\' /etc/init.d/${pg_service_name}",

          command => "/bin/awk \'{gsub(/su - postgres -c/, \"su - ${owner} -c\"); print;}\' ${postgres_dir}/${pg_service_name} > /etc/init.d/${pg_service_name}",
          creates => "/etc/init.d/${pg_service_name}",
        }

        file { "/etc/init.d/${pg_service_name}":
          ensure => present,
          owner   =>  'root',
          group   =>  'root',
          mode    =>  '0755',
          notify  => Service[$pg_service_name],
          require => Exec['set_pg_service_user']
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
