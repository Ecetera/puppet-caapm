#
# == Class: caapm::database
#
# This class manages the CA APM Database PostgreSQL Bundle
#
#

define caapm::database (
  $version = $caapm::params::version,
  $user_install_dir = $caapm::params::user_install_dir,

  # APM Database Settings
  $database = "postgres",
  $db_host = "localhost",
  $db_port = 5432,
  $db_name = "cemdb",
  $db_user_name = "admin",
  $db_user_passwd = "wily",

  $postgres_dir = "database",
  $pg_admin_user = "postgres",
  $pg_admin_passwd = "C@wilyapm90",
  $pg_install_timeout = 240000,
  $pg_as_service = true,

  $owner  = undef,
  $group  = undef,
  $mode   = 755,

){

  $staging_subdir = "${module_name}"

/*
  notify {"database is $database":}
  notify {"db_host is $db_host":}
  notify {"caapm::params::apm_db is $caapm::params::apm_db":}
  notify {"caapm::params::db_host is $caapm::params::db_host":}
  notify {"caapm::params::db_name is $caapm::params::db_name":}
 */

  $service_name = $version ? {
    '9.1.4.0' => $::operatingsystem ? {
        'windows' => 'pgsql-8.4',
        default  => 'postgresql-8.4',
      },
    '9.6.0.0' => $::operatingsystem ? {
        'windows' => 'pgsql-9.2',
         default  => 'postgresql-8.4',
      },
    '9.7.0.27' => $::operatingsystem ? {
        'windows' => 'pgsql-9.2',
         default  => 'postgresql-9.2',
      },
    '9.7.1.16' => $::operatingsystem ? {
        'windows' => 'pgsql-9.2',
         default  => 'postgresql-9.2',
      },
     default => undef
  }

  class { "caapm::osgi":
    apmversion => $version,
  }


  $staging_path = $staging::params::path

  $user_install_dir_em = $::operatingsystem ? {
    'windows' => to_windows_escaped("${user_install_dir}"),
    default  => "${user_install_dir}",
  }

/* ===================================================================== */

  $pkg_name = "CA APM Introscope ${version}"

  $eula_file = 'ca-eula.txt'
  $resp_file = 'Database.ResponseFile.txt'
  $lic_file = "${ipaddress}.em.lic"
  $failed_log = 'silent.install.failed.txt'
  $features = 'Database'
  $upgradeEM = false
  $clusterEM = false

  $puppet_src = "puppet:///modules/${module_name}"

  $resp_src = "${puppet_src}/${resp_file}"

  # determine the executable package
  $pkg_bin = $::operatingsystem ? {
    'windows' => "introscope${version}${operatingsystem}AMD64.exe",
    default  => "introscope${version}linuxAMD64.bin",
  }

  # download the eula.txt
  staging::file { $eula_file:
    source => "${puppet_src}/${version}/${eula_file}",
    subdir => $staging_subdir,
  }

  # download the Enterprise Manager installer
  staging::file { $pkg_bin:
    source => "${puppet_src}/${version}/${pkg_bin}",
    subdir => $staging_subdir,
    require => Staging::File[$eula_file],

  }

  # generate the response file
  file { $resp_file:
    path    => "$staging_path/$staging_subdir/$resp_file",
    ensure  => present,
    force   => true,
    content => template("$module_name/$version/$resp_file"),
#    source_permissions => ignore,
    owner   =>  $owner,
    group   =>  $group,
    mode    =>  $mode,
  }

  $install_options = $::operatingsystem ? {
    'windows' => "$staging_path\\$staging_subdir\\$resp_file",
    default   => "$staging_path/$staging_subdir/$resp_file",
  }


  file { $failed_log :
    path   => "$staging_path/$staging_subdir/$failed_log",
    ensure => absent,
  }

  case $operatingsystem {
    CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {
      exec { $pkg_name :
#        command     => "$staging_path/$staging_subdir/$pkg_bin -f $install_options;cat $staging_path/$staging_subdir/silent.install.failed.txt;true",
        command     => "$staging_path/$staging_subdir/$pkg_bin -f $install_options",
#        creates     =>  "${target_dir}launcher.jar",
        require     => [File[$resp_file], Staging::File[$pkg_bin], File[$failed_log]],
        logoutput   => true,
        returns     => 1,
        timeout     => 0,
        notify      => Service[$service_name],
      }

    }

    windows: {
      # install the Enterprise Manager package
      package { $pkg_name :
        ensure          => "$version",
        source          => "$staging_path/$staging_subdir/$pkg_bin",
        install_options => [" -f $install_options" ],
        require         => [File[$resp_file], Staging::File[$pkg_bin],File["silent.install.failed.txt"]],
        notify          => Service[$service_name],
        allow_virtual   => true,
      }
    }
  }


        # ensure the service is running
        service { $service_name:
          ensure  => $pg_as_service,
          enable  => $pg_as_service,
        }

}
