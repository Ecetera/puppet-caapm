#
# == Class: caapm
#
# Puppet module to manage CA APM
#
# === Parameters
#
# === Variables
#
# === Examples
#
#

class caapm (

  $version                 = $caapm::defaults::version,
  $user_install_dir        = $caapm::defaults::user_install_dir,
  $features                = $caapm::defaults::features,

  # Enterprise Manager Upgrade toggles
  $upgradeEM               = $caapm::defaults::upgradeEM,
  $upgraded_install_dir    = $caapm::defaults::upgraded_install_dir,
  $upgrade_schema          = $caapm::defaults::upgrade_schema,

  # Enteprise Manager Ports Settings
  $default_port            = $caapm::defaults::default_port,
  $ssl_port                = $caapm::defaults::ssl_port,
  $web_port                = $caapm::defaults::web_port,

  # Enterprise Manager User Password Settings
  $admin_passwd            = $caapm::defaults::admin_passwd,
  $guest_passwd            = $caapm::defaults::guest_passwd,

  # Enterprise Manager Clustering Settings
  $clusterEM               = $caapm::defaults::clusterEM,        # Set to true if this Enterprise Manager will participate in a cluster.
  $cluster_role            = $caapm::defaults::cluster_role,    # Specify clustering role for this EM. Valid values are "Collector", "Manager" or "CDV"

  # Enterprise Manager Transaction Storage Settings
  $trace_shelf_life        = $caapm::defaults::trace_shelf_life,
  $trace_dir               = $caapm::defaults::trace_dir,
  $trace_disk_cap          = $caapm::defaults::trace_disk_cap,

  # Enterprise Manager SmartStor Settings
  $smartstor_dir           = $caapm::defaults::smartstor_dir,
  $smartstor_archive       = $caapm::defaults::smartstor_archive,

  # Enterprise Manager Thread Dump Settings
  $threaddump_dir          = $caapm::defaults::threaddump_dir,

  # APM Database Settings
  $database                = $caapm::defaults::database,
  $db_host                 = $caapm::defaults::db_host,
  $db_port                 = $caapm::defaults::db_port,
  $db_name                 = $caapm::defaults::db_name,
  $db_user_name            = $caapm::defaults::db_user_name,
  $db_user_passwd          = $caapm::defaults::db_user_passwd,

  $postgres_dir            = $caapm::defaults::postgres_dir,
  $pg_admin_user           = $caapm::defaults::pg_admin_user,
  $pg_admin_passwd         = $caapm::defaults::pg_admin_passwd,
  $pg_install_timeout      = $caapm::defaults::pg_install_timeout,
  $pg_as_service           = $caapm::defaults::pg_as_service,

  # Enterprise Manager As Windows Service Settings
  $config_em_as_service    = $caapm::defaults::config_em_as_service,
  $em_service_name         = $caapm::defaults::em_service_name,
  $em_display_name         = $caapm::defaults::em_display_name,
  $start_em_as_service     = $caapm::defaults::start_em_as_service,

  # Enterprise Manager Advanced JVM Settings
  $emLaxNlCurrentVm            = $caapm::defaults::emLaxNlCurrentVm,             # Specify the path to the JVM that will be used to run the Enterprise Manager. Leave blank for default
  $emLaxNlJavaOptionAdditional = $caapm::defaults::emLaxNlJavaOptionAdditional,  # Specify any desired command line arguments to be used by the Enterprise Manager JVM.

  # WebView Install Settings
  $webview_port                = $caapm::defaults::webview_port,
  $webview_em_host             = $caapm::defaults::webview_em_host,
  $webview_em_port             = $caapm::defaults::webview_em_port,

  # WebView As Windows Service Settings
  $config_wv_as_service        = $caapm::defaults::config_wv_as_service,
  $wv_service_name             = $caapm::defaults::wv_service_name,
  $wv_display_name             = $caapm::defaults::wv_display_name,
  $start_wv_as_service         = $caapm::defaults::start_wv_as_service,

  # WebView Advanced JVM Settings
  $wvLaxNlCurrentVm            = $caapm::defaults::wvLaxNlCurrentVm,             # Specify the path to the JVM that will be used to run the WebView. Leave blank for default
  $wvLaxNlJavaOptionAdditional = $caapm::defaults::wvLaxNlJavaOptionAdditional,  # Specify any desired command line arguments to be used by the WebView JVM.

  # ProbeBuilder Advanced JVM Settings
  $pbLaxNlCurrentVm            = $caapm::defaults::pbLaxNlCurrentVm,             # Specify the path to the JVM that will be used to run the Workstation. Leave blank for default
  $pbLaxNlJavaOptionAdditional = $caapm::defaults::pbLaxNlJavaOptionAdditional,  # Specify any desired command line arguments to be used by the ProbeBuilder JVM.

  $owner                       = $caapm::defaults::owner,
  $group                       = $caapm::defaults::group,
  $mode                        = $caapm::defaults::mode,

  $puppet_src = "puppet:///modules/${module_name}",



) inherits caapm::defaults {


}
