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
  $pg_ssl                  = $caapm::defaults::pg_ssl,

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
  $smtp_host                   = $caapm::defaults::smtp_host,

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

  $webserver_dir               = $caapm::defaults::webserver_dir,

  $trace_storage_max_data_age            = $caapm::defaults::trace_storage_max_data_age,
  $trace_storage_optimize_frequency      = $caapm::defaults::trace_storage_optimize_frequency,
  $trace_storage_optimize_timeoffsethour = $caapm::defaults::trace_storage_optimize_timeoffsethour,

  # Enterprise Manager SmartStor Settings
  $smartstor_dedicatedcontroller         = $caapm::defaults::smartstor_dedicatedcontroller,
  $smartstor_reperiodizationOffsetHour   = $caapm::defaults::smartstor_reperiodizationOffsetHour,
  $smartstor_conversionOffsetMinute      = $caapm::defaults::smartstor_conversionOffsetMinute,
  $smartstor_tier1_age                   = $caapm::defaults::smartstor_tier1_age,
  $smartstor_tier1_frequency             = $caapm::defaults::smartstor_tier1_frequency,
  $smartstor_tier2_age                   = $caapm::defaults::smartstor_tier2_age,
  $smartstor_tier2_frequency             = $caapm::defaults::smartstor_tier2_frequency,
  $smartstor_tier3_age                   = $caapm::defaults::smartstor_tier3_age,
  $smartstor_tier3_frequency             = $caapm::defaults::smartstor_tier3_frequency,
  $memoryCache_elements                  = $caapm::defaults::memoryCache_elements,
  $baselines_dir                         = $caapm::defaults::baselines_dir,
  $logs_dir                              = $caapm::defaults::logs_dir,

  # Enterprise Manager Thread Dump Settings
  $threaddump_enable                     = $caapm::defaults::threaddump_enable,
  $threaddump_storage_max_disk_usage     = $caapm::defaults::threaddump_storage_max_disk_usage,
  $threaddump_storage_clean_disk_freq_days      = $caapm::defaults::threaddump_storage_clean_disk_freq_days,
  $threaddump_storage_clean_disk_olderthan_days = $caapm::defaults::threaddump_storage_clean_disk_olderthan_days,

  # SNMP Adapter Settings
  $snmp_enable              = $caapm::defaults::snmp_enable,
  $snmp_agent_port          = $caapm::defaults::snmp_agent_port,
  $snmp_notification_enable = $caapm::defaults::snmp_notification_enable,
  $snmp_target_host         = $caapm::defaults::snmp_target_host,
  $snmp_target_port         = $caapm::defaults::snmp_target_port,
  $snmp_target_community    = $caapm::defaults::snmp_target_community,

  # SCARVES Smartcard Authentication
  $scauth_enable            = $caapm::defaults::scauth_enable,
  $scauth_hostname          = $caapm::defaults::scauth_hostname,
  $scauth_port              = $caapm::defaults::scauth_port,
  $scauth_keystore          = $caapm::defaults::scauth_keystore,
  $scauth_keypass           = $caapm::defaults::scauth_keypass,

  # SSA/Catalyst SNMP
  $catalyst_snmp_enable           = $caapm::defaults::catalyst_snmp_enable,
  $catalyst_snmp_destination_host = $caapm::defaults::catalyst_snmp_destination_host,
  $catalyst_snmp_destination_port = $caapm::defaults::catalyst_snmp_destination_port,
  $catalyst_snmp_community        = $caapm::defaults::catalyst_snmp_community,
  $catalyst_snmp_trigger          = $caapm::defaults::catalyst_snmp_trigger,
  $catalyst_data_obsolete_time    = $caapm::defaults::catalyst_data_obsolete_time,

  # Hot Failover Configuration
  $failover_enable                = $caapm::defaults::failover_enable,
  $failover_primary               = $caapm::defaults::failover_primary,
  $failover_secondary             = $caapm::defaults::failover_secondary,
  $failover_interval              = $caapm::defaults::failover_interval,

  # EM Cluster Configuration

  # WebView settings
  $webview_default_url              = $caapm::defaults::webview_default_url,
  $webview_disableLogin             = $caapm::defaults::webview_disableLogin,
  $webview_analysisworkbench_enable = $caapm::defaults::webview_analysisworkbench_enable,


  $em_config_dir                    = $caapm::defaults::em_config_dir,
  $em_auto_unmount_delay            = $caapm::defaults::em_auto_unmount_delay,

  $db_reconnect_interval            = $caapm::defaults::db_reconnect_interval,
  $db_recording_queue_limit         = $caapm::defaults::db_recording_queue_limit,

  # Management Module Hot Deployment
  $hotdeploy_dir                     = $caapm::defaults::hotdeploy_dir,
  $hotdeploy_checkFrequencyInSeconds = $caapm::defaults::hotdeploy_checkFrequencyInSeconds,

  # EM Hot Config
  $hotconfig_enable                  = $caapm::defaults::hotconfig_enable,
  $hotconfig_pollingInterval         = $caapm::defaults::hotconfig_pollingInterval,

  # APM Heuristics
  $apm_overview_baselines            = $caapm::defaults::apm_overview_baselines,


  # Agent Transaction Trace Settings
  $agent_tt_sampling_perinterval_count = $caapm::defaults::agent_tt_sampling_perinterval_count,
  $agent_tt_sampling_interval_seconds  = $caapm::defaults::agent_tt_sampling_interval_seconds,
  $em_tt_compression_index             = $caapm::defaults::em_tt_compression_index,

  # Change Detector settings
  $change_detector_disabled            = $caapm::defaults::change_detector_disabled,

  # Clustering Configuration
  $clustering_collector_id             = $caapm::defaults::clustering_collector_id,
  $clustering_manager_slow_collector_disconnect_threshold_seconds = $caapm::defaults::clustering_manager_slow_collector_disconnect_threshold_seconds,
  $clustering_manager_slow_collector_threshold = $caapm::defaults::clustering_manager_slow_collector_threshold,

  $collector_privatekey             = $caapm::defaults::collector_privatekey,

  # Clustering High Concurrency Pool Configuration
  $high_concurrency_pool_max_size   = $caapm::defaults::high_concurrency_pool_max_size,
  $high_concurrency_pool_min_size   = $caapm::defaults::high_concurrency_pool_min_size,
  $high_concurrency_pool_queue_size = $caapm::defaults::high_concurrency_pool_queue_size,

  # MOM Load Balancing Properties
  $loadbalancing_threshold          = $caapm::defaults::loadbalancing_threshold,
  $loadbalancing_interval           = $caapm::defaults::loadbalancing_interval,

  # Agent Connection Control properties
  $apm_agentcontrol_agent_allowed             = $caapm::defaults::apm_agentcontrol_agent_allowed,
  $apm_agentcontrol_agent_emlistlookup_enable = $caapm::defaults::apm_agentcontrol_agent_emlistlookup_enable,
  $apm_agentcontrol_agent_reconnect_wait      = $caapm::defaults::apm_agentcontrol_agent_reconnect_wait,
  $agent_disallowed_connection_limit          = $caapm::defaults::agent_disallowed_connection_limit,

  # AppMap Agent Config
  $apm_data_agingTime                  = $caapm::defaults::apm_data_agingTime,
  $apm_data_timeWindow                 = $caapm::defaults::apm_data_timeWindow,

  # AppMap Pruning Config
  $apm_pruning_enabled                 = $caapm::defaults::apm_pruning_enabled,
  $apm_data_preserving_time            = $caapm::defaults::apm_data_preserving_time,
  $apm_pruning_cron_trigger_expression = $caapm::defaults::apm_pruning_cron_trigger_expression,

  # Web Services Incidents
  $ws_max_incidents                    = $caapm::defaults::ws_max_incidents,

  # APM SOA calculations
  $soa_deviation_enabled               = $caapm::defaults::soa_deviation_enabled,

  # APM Help URL
  $apm_help_url                        = $caapm::defaults::apm_help_url,

# end of defaults for IntroscopeEnterpriseManager.properties


# defaults for apm-events-thresholds-config.xm
  $em_agent_metrics_limit                                 = $caapm::defaults::em_agent_metrics_limit,
  $em_transactionevents_storage_max_disk_usage            = $caapm::defaults::em_transactionevents_storage_max_disk_usage,
  $em_metrics_live_limit                                  = $caapm::defaults::em_metrics_live_limit,
  $em_metrics_historical_limit                            = $caapm::defaults::em_metrics_historical_limit,
  $em_agent_connection_limit                              = $caapm::defaults::em_agent_connection_limit,
  $em_disconnected_historical_agent_limit                 = $caapm::defaults::em_disconnected_historical_agent_limit,
  $em_events_limit                                        = $caapm::defaults::em_events_limit,
  $em_agent_trace_limit                                   = $caapm::defaults::em_agent_trace_limit,
  $em_agent_error_limit                                   = $caapm::defaults::em_agent_error_limit,
  $apm_clw_max_users                                      = $caapm::defaults::apm_clw_max_users,
  $apm_workstation_max_users                              = $caapm::defaults::apm_workstation_max_users,
  $em_collector_cdv_max                                   = $caapm::defaults::em_collector_cdv_max,
  $em_transaction_discovery_max_nonidentifying_components = $caapm::defaults::em_transaction_discovery_max_nonidentifying_components,
  $em_max_number_domain_configuration_changes             = $caapm::defaults::em_max_number_domain_configuration_changes,
  $em_max_transaction_user_groups                         = $caapm::defaults::em_max_transaction_user_groups,
  $em_max_application_user_rows                           = $caapm::defaults::em_max_application_user_rows,

  $owner                       = $caapm::defaults::owner,
  $group                       = $caapm::defaults::group,
  $mode                        = $caapm::defaults::mode,

  $puppet_src = "puppet:///modules/${module_name}",



) inherits caapm::defaults {


}
