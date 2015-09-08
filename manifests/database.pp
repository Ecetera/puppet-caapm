#
# == Define: caapm::database
#
# This installs the CA APM Database PostgreSQL Bundle
#
#

class caapm::database (


  $version                 = $::caapm::version,
  $user_install_dir        = $::caapm::user_install_dir,
  $features                = $::caapm::features,

  # APM Database Settings
  $database                = $::caapm::database,
  $db_host                 = $::caapm::db_host,
  $db_port                 = $::caapm::db_port,
  $db_name                 = $::caapm::db_name,
  $db_user_name            = $::caapm::db_user_name,
  $db_user_passwd          = $::caapm::db_user_passwd,

  $postgres_dir            = $::caapm::postgres_dir,
  $pg_admin_user           = $::caapm::pg_admin_user,
  $pg_admin_passwd         = $::caapm::pg_admin_passwd,
  $pg_install_timeout      = $::caapm::pg_install_timeout,
  $config_pg_as_service    = $::caapm::config_pg_as_service,
  $pg_ssl                  = $::caapm::pg_ssl,

  $owner                   = $::caapm::owner,
  $group                   = $::caapm::group,
  $mode                    = $::caapm::mode,

  $puppet_src              = "puppet:///modules/${module_name}",
  $notify_enabled          = $::caapm::notify_enabled,


){


  include caapm::em::install
  include caapm::db::config
  include caapm::db::service

  Class['caapm::em::install'] ->
  Class['caapm::db::config']  ->
  Class['caapm::db::service']

  anchor {
    'caapm::begin':
       before  => Class['caapm::em::install','caapm::db::config'],
       notify  => Class['caapm::db::service'];
    'caapm::end':
       require => Class['caapm::db::service'];
  }

}
