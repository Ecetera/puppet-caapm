# 
# == Class: caapm::database
#
# This class manages the CA APM Database PostgreSQL Bundle 
#
#
class caapm::database (
  $version = $caapm::params::version,
  $user_install_dir = $caapm::params::user_install_dir,  
      
  # APM Database Settings
  $database = $caapm::params::apm_db,
  $db_host = $caapm::params::db_host,
  $db_port = $caapm::params::db_port,
  $db_name = $caapm::params::db_name,
  $db_user_name = $caapm::params::db_user_name,
  $db_user_passwd = $caapm::params::db_user_passwd,

  $postgres_dir = $caapm::params::pg_dir,
  $pg_admin_user = $caapm::params::pg_admin_user,
  $pg_admin_passwd = $caapm::params::pg_admin_passwd,
  $pg_install_timeout = $caapm::params::pg_install_timeout,
  $pg_as_service = $caapm::params::pg_as_service,
   
) inherits caapm::params {
  
  
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

  
/* ======================================================================  

  class {'caapm::em': 
    version => $version,
    features => 'Database',
    user_install_dir => $user_install_dir,
    
    # APM Database Settings
    database => $database,
    db_host => $db_host,
    db_port => $db_port,
    db_name => $db_name,
    db_user_name => $db_user_name,
    db_user_passwd => $db_user_passwd,
    postgres_dir => $postgres_dir,
    pg_admin_user => $pg_admin_user,
    pg_admin_passwd => $pg_admin_passwd,
    pg_install_timeout => $pg_install_timeout,
    config_as_service => false,
    config_wv_as_service => false,
    notify  => Service[$service_name],
  }
 
    # ensure the service is running
  service { $service_name:
    ensure  => "running",
    enable  => true,
  }
 */
}
