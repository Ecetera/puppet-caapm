class caapm::defaults {

  $version                 = '9.7.1.16'

# defaults for EnterpriseManager.ResponseFile.txt
  $user_install_dir        = "/app/caapm/Introscope${version}/"
  $features                = 'Enterprise Manager,WebView'

  # Enterprise Manager Upgrade toggle
  $upgradeEM               = false
  $upgraded_install_dir    = undef
  $upgrade_schema          = false

  # Enteprise Manager Ports Settings
  $default_port            = 5001
  $ssl_port                = 5443
  $web_port                = 8081

  # Enterprise Manager User Password Settings
  $admin_passwd            = undef
  $guest_passwd            = undef

  # Enterprise Manager Clustering Settings
  $clusterEM               = false        # Set to true if this Enterprise Manager will participate in a cluster.
  $cluster_role            = 'StandAlone' # Specify clustering role for this EM. Valid values are "Collector", "Manager" or "CDV"

  # Enterprise Manager Transaction Storage Settings
  $trace_shelf_life        = 14
  $trace_dir               = 'trace'
  $trace_disk_cap          = undef

  # Enterprise Manager SmartStor Settings
  $smartstor_dir           = 'data'

  # Enterprise Manager Thread Dump Settings
  $threaddump_dir          = 'threaddump'

  # APM Database Settings
  $database                = 'postgresql'
  $db_host                 = 'localhost'
  $db_port                 = 5432
  $db_name                 = 'cemdb'
  $db_user_name            = 'admin'
  $db_user_passwd          = 'wily'

  $postgres_dir            = 'database'
  $pg_admin_user           = 'postgres'
  $pg_admin_passwd         = 'C@wilyapm90'
  $pg_install_timeout      = 240000
  $pg_as_service           = true

  # Enterprise Manager As Windows Service Settings
  $config_em_as_service    = false
  $start_em_as_service     = true

  # Enterprise Manager Advanced JVM Settings
  $emLaxNlCurrentVm            = ''     # Specify the path to the JVM that will be used to run the Enterprise Manager. Leave blank for default
  $emLaxNlJavaOptionAdditional = ''  # Specify any desired command line arguments to be used by the Enterprise Manager JVM.
#  $emLaxNlJavaOptionAdditional = '-Xms512m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',

  # WebView Install Settings
  $webview_port                = 8080
  $webview_em_host             = 'localhost'
  $webview_em_port             = 5001

  # WebView As Windows Service Settings
  $config_wv_as_service        = false
  $start_wv_as_service         = true

  # WebView Advanced JVM Settings
  $wvLaxNlCurrentVm            = ''     # Specify the path to the JVM that will be used to run the WebView. Leave blank for default
  $wvLaxNlJavaOptionAdditional = ''  # Specify any desired command line arguments to be used by the WebView JVM.
#  $wvLaxNlJavaOptionAdditional='-Xms128m -Xmx512m -Djava.awt.headless=true -Dorg.owasp.esapi.resources=./config/esapi'

  # ProbeBuilder Advanced JVM Settings
  $pbLaxNlCurrentVm            = ''     # Specify the path to the JVM that will be used to run the Workstation. Leave blank for default
  $pbLaxNlJavaOptionAdditional = ''  # Specify any desired command line arguments to be used by the ProbeBuilder JVM.
#  $pbLaxNlJavaOptionAdditional ='-Xms32m -Xmx64m'

# end of defaults for EnterpriseManager.ResponseFile.txt

  $osgi_eula_file              = 'eula.txt'
  $pkg_name                    = "CA APM Introscope ${version}"
  $eula_file                   = 'ca-eula.txt'
  $resp_file                   = 'EnterpriseManager.ResponseFile.txt'
  $lic_file                    = "${::ipaddress}.em.lic"
  $failed_log                  = 'silent.install.failed.txt'



# defaults for IntroscopeEnterpriseManager.properties
  $em_home                     = undef
  $webserver_dir               = 'webapps'

  $trace_storage_max_data_age            = 14
  $trace_storage_optimize_frequency      = 24
  $trace_storage_optimize_timeoffsethour = 02

  # Enterprise Manager SmartStor Settings
  $smartstor_archive                     = 'data/archive'
  $smartstor_dedicatedcontroller         = false
  $smartstor_reperiodizationOffsetHour   = 0
  $smartstor_conversionOffsetMinute      = 0
  $smartstor_tier1_age                   = 7
  $smartstor_tier1_frequency             = 15
  $smartstor_tier2_age                   = 23
  $smartstor_tier2_frequency             = 60
  $smartstor_tier3_age                   = 335
  $smartstor_tier3_frequency             = 900
  $memoryCache_elements                  = 32
  $baselines_dir                         = 'data'

  # Enterprise Manager Thread Dump Settings
  $threaddump_enable                     = true
  $threaddump_storage_max_disk_usage     = 5000
  $threaddump_storage_clean_disk_freq_days      = 1
  $threaddump_storage_clean_disk_olderthan_days = 30

  # SNMP Adapter Settings
  $snmp_enable              = false
  $snmp_agent_port          = 161
  $snmp_notification_enable = true
  $snmp_target_host         = 'localhost'
  $snmp_target_port         = 162
  $snmp_target_community    = 'public'

  # SCARVES Smartcard Authentication
  $scauth_enable            = false
  $scauth_hostname          = 'localhost'
  $scauth_port              = 9998
  $scauth_keystore          = 'config/internal/server/daemoncert'
  $scauth_keypass           = 'password'

  # SSA/Catalyst SNMP
  $catalyst_snmp_enable           = false
  $catalyst_snmp_destination_host = undef
  $catalyst_snmp_destination_port = 162
  $catalyst_snmp_community        = 'public'
  $catalyst_snmp_trigger          = 3
  $catalyst_data_obsolete_time    = '300 DAYS'

  # Hot Failover Configuration
  $failover_enable                = false
  $failover_primary               = undef
  $failover_secondary             = undef
  $failover_interval              = 120

  # EM Cluster Configuration

  # WebView settings
  $webview_default_url              = 'http://localhost:8080'
  $webview_disableLogin             = false
  $webview_analysisworkbench_enable = true


  $em_config_dir                    = 'config'
  $em_auto_unmount_delay            = 60

  $db_reconnect_interval            =30
  $db_recording_queue_limit         =153600

  # Management Module Hot Deployment
  $hotdeploy_dir                     = 'deploy'
  $hotdeploy_checkFrequencyInSeconds = 60

  # EM Hot Config
  $hotconfig_enable                  = true
  $hotconfig_pollingInterval         = 60

  # APM Heuristics
  $apm_overview_baselines            = true


  # Agent Transaction Trace Settings
  $agent_tt_sampling_perinterval_count = 1
  $agent_tt_sampling_interval_seconds  = 120
  $em_tt_compression_index             = 3

  # Change Detector settings
  $change_detector_disabled            = true

  # Clustering Configuration
  $clustering_collector_id                                        = $::fqdn  #hiera_lookup - dns alias
  $clustering_manager_slow_collector_disconnect_threshold_seconds = 60
  $clustering_manager_slow_collector_threshold = 10000

  $collector_privatekey             = 'internal/server/EM.private'

  # Clustering High Concurrency Pool Configuration
  $high_concurrency_pool_max_size   = 5
  $high_concurrency_pool_min_size   = 5
  $high_concurrency_pool_queue_size = 6000

  # MOM Load Balancing Properties
  $loadbalancing_threshold          = 20000
  $loadbalancing_interval           = 600

  # Agent Connection Control properties
  $apm_agentcontrol_agent_allowed             = true
  $apm_agentcontrol_agent_emlistlookup_enable = true
  $apm_agentcontrol_agent_reconnect_wait      = 45
  $agent_disallowed_connection_limit          = 0

  # AppMap Agent Config
  $apm_data_agingTime                  = '1 DAY'
  $apm_data_timeWindow                 = '3 DAYS'

  # AppMap Pruning Config
  $apm_pruning_enabled                 = true
  $apm_data_preserving_time            = '365 DAYS'
  $apm_pruning_cron_trigger_expression = '0 0 6 * * ?'

  # Web Services Incidents
  $ws_max_incidents                    = 500

  # APM SOA calculations
  $soa_deviation_enabled               = false

  # APM Help URL
  $apm_help_url                        = 'https://wiki.ca.com/display/APMDEVOPS97/CA+Application+Performance+Management'

# end of defaults for IntroscopeEnterpriseManager.properties


# defaults for apm-events-thresholds-config.xm
  $em_agent_metrics_limit                                 = 50000
  $em_transactionevents_storage_max_disk_usage            = 1024
  $em_metrics_live_limit                                  = 500000
  $em_metrics_historical_limit                            = 1200000
  $em_agent_connection_limit                              = 400
  $em_disconnected_historical_agent_limit                 = 400
  $em_events_limit                                        = 1250
  $em_agent_trace_limit                                   = 1000
  $em_agent_error_limit                                   = 10
  $apm_clw_max_users                                      = 500
  $apm_workstation_max_users                              = 40
  $em_collector_cdv_max                                   = 5
  $em_transaction_discovery_max_nonidentifying_components = 50
  $em_max_number_domain_configuration_changes             = 0
  $em_max_transaction_user_groups                         = 5000
  $em_max_application_user_rows                           = 1000

# end of defaults for apm-events-thresholds-config.xm



#  $clustering.login.em1.host=hostname
#  $clustering.login.em1.port=5001
#  $clustering.login.em1.publickey=internal/server/EM.public
#  $clustering.login.em1.weight=

  $mode   = '0644'

  $puppet_src = "puppet:///modules/${module_name}"

  $user_install_dir_em = $::operatingsystem ? {
    'windows' => to_windows_escaped($user_install_dir),
    default  => $user_install_dir,
  }

  $target_dir = $upgradeEM ? {
    false => $user_install_dir_em,
    true  => $::operatingsystem ? {
      'windows' => to_windows_escaped($upgraded_install_dir),
      default  => $upgraded_install_dir,
    },
    default => $user_install_dir_em
  }

  case $::operatingsystem {
    CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {
      $stage_dir       = '/tmp'
      $osgi_pkg_name   = "osgiPackages.v${version}.unix.tar"
      $pkg_bin         =  "introscope${version}linuxAMD64.bin"
      $em_service_name = 'introscope'
      $em_display_name = undef
      $wv_service_name = 'webview'
      $wv_display_name = undef
      $owner           = 'caapm'
      $group           = 'apm'
    }
    windows: {
      $stage_dir       = 'C:\\Windows\\Temp'
      $osgi_pkg_name   = "osgiPackages.v${version}.windows.zip"
      $pkg_bin         = "introscope${version}${::operatingsystem}AMD64.exe"
      $em_service_name = 'IScopeEM'
      $em_display_name = 'Introscope Enterprise Manager'
      $wv_service_name = 'IScopeWV'
      $wv_display_name = 'Introscope WebView'
      $owner           = 'Administrator'
      $group           = 'Users'
    }
    default: {
      $stage_dir = undef
      $owner     = 'default_user'
      $group     = 'default_group'
    }
  }
}
