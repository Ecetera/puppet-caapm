
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
  $smtp_host                   = $::caapm::smtp_host,

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

# defaults for IntroscopeEnterpriseManager.properties
  $webserver_dir               = $::caapm::webserver_dir,

  $trace_storage_max_data_age            = $::caapm::trace_storage_max_data_age,
  $trace_storage_optimize_frequency      = $::caapm::trace_storage_optimize_frequency,
  $trace_storage_optimize_timeoffsethour = $::caapm::trace_storage_optimize_timeoffsethour,

  # Enterprise Manager SmartStor Settings
  $smartstor_archive                     = $::caapm::smartstor_archive,
  $smartstor_dedicatedcontroller         = $::caapm::smartstor_dedicatedcontroller,
  $smartstor_reperiodizationOffsetHour   = $::caapm::smartstor_reperiodizationOffsetHour,
  $smartstor_conversionOffsetMinute      = $::caapm::smartstor_conversionOffsetMinute,
  $smartstor_tier1_age                   = $::caapm::smartstor_tier1_age,
  $smartstor_tier1_frequency             = $::caapm::smartstor_tier1_frequency,
  $smartstor_tier2_age                   = $::caapm::smartstor_tier2_age,
  $smartstor_tier2_frequency             = $::caapm::smartstor_tier2_frequency,
  $smartstor_tier3_age                   = $::caapm::smartstor_tier3_age,
  $smartstor_tier3_frequency             = $::caapm::smartstor_tier3_frequency,
  $memoryCache_elements                  = $::caapm::memoryCache_elements,
  $baselines_dir                         = $::caapm::baselines_dir,

  # Enterprise Manager Thread Dump Settings
  $threaddump_enable                     = $::caapm::threaddump_enable,
  $threaddump_storage_max_disk_usage     = $::caapm::threaddump_storage_max_disk_usage,
  $threaddump_storage_clean_disk_freq_days      = $::caapm::threaddump_storage_clean_disk_freq_days,
  $threaddump_storage_clean_disk_olderthan_days = $::caapm::threaddump_storage_clean_disk_olderthan_days,

  # SNMP Adapter Settings
  $snmp_enable              = $::caapm::snmp_enable,
  $snmp_agent_port          = $::caapm::snmp_agent_port,
  $snmp_notification_enable = $::caapm::snmp_notification_enable,
  $snmp_target_host         = $::caapm::snmp_target_host,
  $snmp_target_port         = $::caapm::snmp_target_port,
  $snmp_target_community    = $::caapm::snmp_target_community,

  # SCARVES Smartcard Authentication
  $scauth_enable            = $::caapm::scauth_enable,
  $scauth_hostname          = $::caapm::scauth_hostname,
  $scauth_port              = $::caapm::scauth_port,
  $scauth_keystore          = $::caapm::scauth_keystore,
  $scauth_keypass           = $::caapm::scauth_keypass,

  # SSA/Catalyst SNMP
  $catalyst_snmp_enable           = $::caapm::catalyst_snmp_enable,
  $catalyst_snmp_destination_host = $::caapm::catalyst_snmp_destination_host,
  $catalyst_snmp_destination_port = $::caapm::catalyst_snmp_destination_port,
  $catalyst_snmp_community        = $::caapm::catalyst_snmp_community,
  $catalyst_snmp_trigger          = $::caapm::catalyst_snmp_trigger,
  $catalyst_data_obsolete_time    = $::caapm::catalyst_data_obsolete_time,

  # Hot Failover Configuration
  $failover_enable                = $::caapm::failover_enable,
  $failover_primary               = $::caapm::failover_primary,
  $failover_secondary             = $::caapm::failover_secondary,
  $failover_interval              = $::caapm::failover_interval,

  # EM Cluster Configuration

  # WebView settings
  $webview_default_url              = $::caapm::webview_default_url,
  $webview_disableLogin             = $::caapm::webview_disableLogin,
  $webview_analysisworkbench_enable = $::caapm::webview_analysisworkbench_enable,


  $em_config_dir                    = $::caapm::em_config_dir,
  $em_auto_unmount_delay            = $::caapm::em_auto_unmount_delay,

  $db_reconnect_interval            = $::caapm::db_reconnect_interval,
  $db_recording_queue_limit         = $::caapm::db_recording_queue_limit,

  # Management Module Hot Deployment
  $hotdeploy_dir                     = $::caapm::hotdeploy_dir,
  $hotdeploy_checkFrequencyInSeconds = $::caapm::hotdeploy_checkFrequencyInSeconds,

  # EM Hot Config
  $hotconfig_enable                  = $::caapm::hotconfig_enable,
  $hotconfig_pollingInterval         = $::caapm::hotconfig_pollingInterval,

  # APM Heuristics
  $apm_overview_baselines            = $::caapm::apm_overview_baselines,


  # Agent Transaction Trace Settings
  $agent_tt_sampling_perinterval_count = $::caapm::agent_tt_sampling_perinterval_count,
  $agent_tt_sampling_interval_seconds  = $::caapm::agent_tt_sampling_interval_seconds,
  $em_tt_compression_index             = $::caapm::em_tt_compression_index,

  # Change Detector settings
  $change_detector_disabled            = $::caapm::change_detector_disabled,

  # Clustering Configuration
  $clustering_collector_id             = $::caapm::clustering_collector_id,
  $clustering_manager_slow_collector_disconnect_threshold_seconds = $::caapm::clustering_manager_slow_collector_disconnect_threshold_seconds,
  $clustering_manager_slow_collector_threshold = $::caapm::clustering_manager_slow_collector_threshold,

  $collector_privatekey             = $::caapm::collector_privatekey,

  # Clustering High Concurrency Pool Configuration
  $high_concurrency_pool_max_size   = $::caapm::high_concurrency_pool_max_size,
  $high_concurrency_pool_min_size   = $::caapm::high_concurrency_pool_min_size,
  $high_concurrency_pool_queue_size = $::caapm::high_concurrency_pool_queue_size,

  # MOM Load Balancing Properties
  $loadbalancing_threshold          = $::caapm::loadbalancing_threshold,
  $loadbalancing_interval           = $::caapm::loadbalancing_interval,

  # Agent Connection Control properties
  $apm_agentcontrol_agent_allowed             = $::caapm::apm_agentcontrol_agent_allowed,
  $apm_agentcontrol_agent_emlistlookup_enable = $::caapm::apm_agentcontrol_agent_emlistlookup_enable,
  $apm_agentcontrol_agent_reconnect_wait      = $::caapm::apm_agentcontrol_agent_reconnect_wait,
  $agent_disallowed_connection_limit          = $::caapm::agent_disallowed_connection_limit,

  # AppMap Agent Config
  $apm_data_agingTime                  = $::caapm::apm_data_agingTime,
  $apm_data_timeWindow                 = $::caapm::apm_data_timeWindow,

  # AppMap Pruning Config
  $apm_pruning_enabled                 = $::caapm::apm_pruning_enabled,
  $apm_data_preserving_time            = $::caapm::apm_data_preserving_time,
  $apm_pruning_cron_trigger_expression = $::caapm::apm_pruning_cron_trigger_expression,

  # Web Services Incidents
  $ws_max_incidents                    = $::caapm::ws_max_incidents,

  # APM SOA calculations
  $soa_deviation_enabled               = $::caapm::soa_deviation_enabled,

  # APM Help URL
  $apm_help_url                        = $::caapm::apm_help_url,

# end of defaults for IntroscopeEnterpriseManager.properties


# defaults for apm-events-thresholds-config.xm
  $em_agent_metrics_limit                                 = $::caapm::em_agent_metrics_limit,
  $em_transactionevents_storage_max_disk_usage            = $::caapm::em_transactionevents_storage_max_disk_usage,
  $em_metrics_live_limit                                  = $::caapm::em_metrics_live_limit,
  $em_metrics_historical_limit                            = $::caapm::em_metrics_historical_limit,
  $em_agent_connection_limit                              = $::caapm::em_agent_connection_limit,
  $em_disconnected_historical_agent_limit                 = $::caapm::em_disconnected_historical_agent_limit,
  $em_events_limit                                        = $::caapm::em_events_limit,
  $em_agent_trace_limit                                   = $::caapm::em_agent_trace_limit,
  $em_agent_error_limit                                   = $::caapm::em_agent_error_limit,
  $apm_clw_max_users                                      = $::caapm::apm_clw_max_users,
  $apm_workstation_max_users                              = $::caapm::apm_workstation_max_users,
  $em_collector_cdv_max                                   = $::caapm::em_collector_cdv_max,
  $em_transaction_discovery_max_nonidentifying_components = $::caapm::em_transaction_discovery_max_nonidentifying_components,
  $em_max_number_domain_configuration_changes             = $::caapm::em_max_number_domain_configuration_changes,
  $em_max_transaction_user_groups                         = $::caapm::em_max_transaction_user_groups,
  $em_max_application_user_rows                           = $::caapm::em_max_application_user_rows,

  $owner                       = $::caapm::owner,
  $group                       = $::caapm::group,
  $mode                        = $::caapm::mode,

  $puppet_src = "puppet:///modules/${module_name}"


)
# inherits caapm::defaults
{

  include caapm::em::install
  include caapm::em::config
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
