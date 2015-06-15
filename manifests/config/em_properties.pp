class caapm::config::em_properties (

  $em_home = $::caapm::em_home,

  # Enteprise Manager Ports Settings
  $default_port = 5001,
  $secure_port  = 5443,
  $webserver_port = 8081,
  $webserver_dir = 'webapps',

  # Enterprise Manager User Password Settings
  $admin_passwd = undef,

  $guest_passwd = undef,

  # Enterprise Manager Transaction Storage Settings
  $txnTraceDiskSpaceCap = undef,

  $transactionevents_dir = $::caapm::txnTraceDir,
  $transactionevents_storage_max_data_age = 14,
  $transactionevents_storage_optimize_frequency = 24,
  $transactionevents_storage_optimize_timeoffsethour = 02,

  # Enterprise Manager SmartStor Settings
  $smartstor_dir = $::caapm::smartstor_dir,
  $smartstor_archive = $::caapm::smartstor_archive,
  $smartstor_dedicatedcontroller = false,
  $smartstor_reperiodizationOffsetHour = 0,
  $smartstor_conversionOffsetMinute = 0,
  $smartstor_tier1_age = 7,
  $smartstor_tier1_frequency = 15,
  $smartstor_tier2_age = 23,
  $smartstor_tier2_frequency = 60,
  $smartstor_tier3_age = 335,
  $smartstor_tier3_frequency = 900,
  $memoryCache_elements = 32,
  $baselines_dir = $::caapm::db_file,

  # Enterprise Manager Thread Dump Settings
  $threaddump_enable = true,
  $threaddump_dir = $::caapm::threaddump_dir,
  $threaddump_storage_max_disk_usage = 5000,
  $threaddump_storage_clean_disk_freq_days = 1,
  $threaddump_storage_clean_disk_olderthan_days = 30,

  # APM Database Settings
  $database = 'postgres',
  $db_host = 'localhost',
  $db_port = 5432,
  $db_name = 'cemdb',
  $db_user_name = 'admin',
  $db_user_passwd = 'wily',



  # SNMP Adapter Settings
  $snmp_enable = false,
  $snmp_agent_port = 161,
  $snmp_notification_enable = true,
  $snmp_target_host = 'localhost',
  $snmp_target_port = 162,
  $snmp_target_community = 'public',

  # SCARVES Smartcard Authentication
  $scauth_enable = false,
  $scauth_hostname = 'localhost',
  $scauth_port = 9998,
  $scauth_keystore = 'config/internal/server/daemoncert',
  $scauth_keypass = 'password',

  # SSA/Catalyst SNMP
  $catalyst_snmp_enable = false,
  $catalyst_snmp_destination_host = undef,
  $catalyst_snmp_destination_port = 162,
  $catalyst_snmp_community = 'public',
  $catalyst_snmp_trigger = 3,
  $catalyst_data_obsolete_time = '300 DAYS',

  # Hot Failover Configuration
  $failover_enable = false,
  $failover_primary = undef,
  $failover_secondary = undef,
  $failover_interval = 120,

  # EM Cluster Configuration

  # WebView settings
  $webview_default_url = 'http://localhost:8080',
  $webview_disableLogin = false,
  $webview_analysisworkbench_enable = true,


  $em_config_dir = 'config',
  $em_auto_unmount_delay = 60,

  $db_reconnect_interval=30,
  $db_recording_queue_limit=153600,

  # Management Module Hot Deployment
  $hotdeploy_dir = 'deploy',
  $hotdeploy_checkFrequencyInSeconds = 60,

  # EM Hot Config
  $hotconfig_enable = true,
  $hotconfig_pollingInterval=60,

  # APM Heuristics
  $apm_overview_baselines = true,


  # Agent Transaction Trace Settings
  $agent_tt_sampling_perinterval_count = 1,
  $agent_tt_sampling_interval_seconds = 120,
  $em_tt_compression_index = 3,

  # Change Detector settings
  $change_detector_disabled = true,

  # Clustering Configuration
  $cluster_role = 'StandAlone',
  $clustering_collector_id = $::fqdn,  #hiera_lookup - dns alias
  $clustering_manager_slow_collector_disconnect_threshold_seconds = 60,
  $clustering_manager_slow_collector_threshold = 10000,

  $collector_privatekey = 'internal/server/EM.private',

  # Clustering High Concurrency Pool Configuration
  $high_concurrency_pool_max_size = 5,
  $high_concurrency_pool_min_size = 5,
  $high_concurrency_pool_queue_size = 6000,

  # MOM Load Balancing Properties
  $loadbalancing_threshold = 20000,
  $loadbalancing_interval = 600,

  # Agent Connection Control properties
  $apm_agentcontrol_agent_allowed = true,
  $apm_agentcontrol_agent_emlistlookup_enable = true,
  $apm_agentcontrol_agent_reconnect_wait = 45,
  $agent_disallowed_connection_limit = 0,

  # AppMap Agent Config
  $apm_data_agingTime = '1 DAY',
  $apm_data_timeWindow = '3 DAYS',

  # AppMap Pruning Config
  $apm_pruning_enabled = true,
  $apm_data_preserving_time = '365 DAYS',
  $apm_pruning_cron_trigger_expression = '0 0 6 * * ?',

  # Web Services Incidents
  $ws_max_incidents = 500,

  # APM SOA calculations
  $soa_deviation_enabled = false,

  # APM Help URL
  $apm_help_url = 'https://wiki.ca.com/display/APMDEVOPS97/CA+Application+Performance+Management',

#---------------------

#  $clustering.login.em1.host=hostname
#  $clustering.login.em1.port=5001
#  $clustering.login.em1.publickey=internal/server/EM.public
#  $clustering.login.em1.weight=


  $owner  = $caapm::owner,
  $group  = $caapm::group,
  $mode   = $caapm::mode,
  $version = $caapm::version

){

  validate_absolute_path($em_home)

  $em_properties = "IntroscopeEnterpriseManager.properties"

  file { $em_properties:
    ensure => present,
    force  => true,
    path    => "${em_home}/config/${em_properties}",
    content => template("${module_name}/${version}/${em_properties}"),
    owner   =>  $owner,
    group   =>  $group,
    mode    =>  $mode,
  }
  ->
  file_line { 'disable_single_channel':
    path     => "${em_home}/config/${em_properties}",
    line     => '#introscope.enterprisemanager.enabled.channels=channel1',
    match    => 'introscope\.enterprisemanager\.enabled\.channels=channel1$',
    multiple => false,
  }
  ->
  file_line { 'enable_both_channels':
    path     => "${em_home}/config/${em_properties}",
    line     => 'introscope.enterprisemanager.enabled.channels=channel1,channel2',
    match    => 'introscope\.enterprisemanager\.enabled\.channels=channel1,channel2$',
    multiple => false,
  }


}
