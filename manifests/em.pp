
class caapm::em (

  $version                 = $::caapm::version,
  $user_install_dir        = $::caapm::user_install_dir,
  $features                = $::caapm::features,

  # Enterprise Manager Upgrade toggles
  $upgradeEM               = $::caapm::upgradeEM,
  $upgraded_install_dir    = $::caapm::upgrade_install_dir,
  $upgrade_schema          = $::caapm::upgrade_schema,

  # Enteprise Manager Ports Settings
  $default_port            = $::caapm::default_port,
  $ssl_port                = $::caapm::secure_port,
  $web_port                = $::caapm::web_port,

  # Enterprise Manager User Password Settings
  $admin_passwd            = $::caapm::admin_passwd,
  $guest_passwd            = $::caapm::guest_passwd,

  # Enterprise Manager Clustering Settings
  $clusterEM               = $::caapm::cluserEM,        # Set to true if this Enterprise Manager will participate in a cluster.
  $cluster_role            = $::caapm::cluster_role,    # Specify clustering role for this EM. Valid values are "Collector", "MOM" or "CDV"

  # Enterprise Manager Transaction Storage Settings
  $txnTraceDataShelfLife   = $::caapm::trace_shelf_life,
  $txnTraceDir             = $::caapm::trace_dir,
  $txnTraceDiskSpaceCap    = $::caapm::trace_disk_cap,

  # Enterprise Manager SmartStor Settings
  $smartstor_dir           = $::caapm::smartstor_dir,

  # Enterprise Manager Thread Dump Settings
  $threaddump_dir          = $::caapm::threaddump_dir,

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
  $pg_as_service           = $::caapm::pg_as_service,

  # Enterprise Manager As Windows Service Settings
  $config_em_as_service    = $::caapm::config_em_as_service,
  $em_service_name         = $::caapm::em_service_name,
  $em_service_display_name = $::caapm::em_service_display_name,
  $start_em_as_service     = $::caapm::start_em_as_service,

  # Enterprise Manager Advanced JVM Settings
  $emLaxNlCurrentVm            = $::caapm::emLaxNlCurrentVm,             # Specify the path to the JVM that will be used to run the Enterprise Manager. Leave blank for default
  $emLaxNlJavaOptionAdditional = $::caapm::emLaxNlJavaOptionAdditional,  # Specify any desired command line arguments to be used by the Enterprise Manager JVM.

  # WebView Install Settings
  $webview_port                = $::caapm::webview_port,
  $webview_em_host             = $::caapm::webview_em_host,
  $webview_em_port             = $::caapm::webview_em_port,

  # WebView As Windows Service Settings
  $config_wv_as_service        = $::caapm::config_wv_as_service,
  $wv_service_name             = $::caapm::wv_service_name,
  $wv_service_display_name     = $::caapm::wv_service_display_name,
  $start_wv_as_service         = $::caapm::start_wv_as_service,

  # WebView Advanced JVM Settings
  $wvLaxNlCurrentVm            = $::caapm::wvLaxNlCurrentVm,             # Specify the path to the JVM that will be used to run the WebView. Leave blank for default
  $wvLaxNlJavaOptionAdditional = $::caapm::wvLaxNlJavaOptionAdditional,  # Specify any desired command line arguments to be used by the WebView JVM.

  # ProbeBuilder Advanced JVM Settings
  $pbLaxNlCurrentVm            = $::caapm::pbLaxNlCurrentVm,             # Specify the path to the JVM that will be used to run the Workstation. Leave blank for default
  $pbLaxNlJavaOptionAdditional = $::caapm::pbLaxNlJavaOptionAdditional,  # Specify any desired command line arguments to be used by the ProbeBuilder JVM.

  $owner                       = $::caapm::owner,
  $group                       = $::caapm::group,
  $mode                        = $::caapm::mode,

  $puppet_src = "puppet:///modules/${module_name}"


)
# inherits caapm::defaults
{

  include caapm::em::install
  include caapm::em::config
#  include caapm::em::plugins
  include caapm::em::service

  Class['caapm::em::install'] ->
  Class['caapm::em::config']  ->
#  Class['caapm::em::plugins']  ->
  Class['caapm::em::service']

  anchor {
    'caapm::begin':
       before  => Class['caapm::em::install','caapm::em::config'],
       notify  => Class['caapm::em::service'];
    'caapm::end':
       require => Class['caapm::em::service'];
  }

}
