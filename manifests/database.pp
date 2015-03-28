# Class: caapm::database
#
# This class manages the CA APM Database PostgreSQL Bundle
#
# Parameters:
# - $version the osgi version to download and install.
# - $souce_path the source location to obtain the files from.
#
class caapm::database (
  $version = $caapm::params::version,
  $install_dir = $caapm::params::install_dir,  
      
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
   
  # Enterprise Manager As Windows Service Settings
  $config_as_service = false,
  $config_wv_as_service = false,

) inherits caapm::params {
  
  $service_name  = $::operatingsystem ? {
    'windows' => 'pgsql-8.4',
     default  => 'postgresql-8.4',
  }
  
  class {'caapm::em': 
    features => 'Database',
    install_dir => $install_dir,
    
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
    notify  => Service[$service_name],
  }
  
    # ensure the service is running
  service { $service_name:
    ensure  => "running",
    enable  => true,
  }
  
/*  
  file { $lic_file:
    source => "${puppet_src}/license/${lic_file}",
    notify  => Service[$service_name],  
    path => "${install_dir}license/${lic_file}",
    require => Package[$pkg_name],
  }  
 */   
}
