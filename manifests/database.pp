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
   
  # Enterprise Manager As Windows Service Settings
  $config_as_service = false,
  $config_wv_as_service = false,

) inherits caapm::params {
  
  contain caapm::em
  
  $service_name = $version ? {
    '9.1.4.0' => $::operatingsystem ? {
        'windows' => 'pgsql-8.4',
        default  => 'postgresql-8.4',
      },
    '9.6.0.0' => $::operatingsystem ? {
        'windows' => 'pgsql-9.2',
         default  => 'postgresql-9.2',
      },
    '9.7.0.27' => $::operatingsystem ? {
        'windows' => 'pgsql-9.2',
         default  => 'postgresql-9.2',
      },
    '9.7.1.27' => $::operatingsystem ? {
        'windows' => 'pgsql-9.2',
         default  => 'postgresql-9.2',
      },
     default => undef
  }
  
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
    notify  => Service[$service_name],
  }
  
    # ensure the service is running
  service { $service_name:
    ensure  => "running",
    enable  => true,
  }
  
}
