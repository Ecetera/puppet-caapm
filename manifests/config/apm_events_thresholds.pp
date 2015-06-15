class caapm::config::apm_events_thresholds (

  $em_home = $::caapm::em_home,
  $em_agent_metrics_limit = 50000,  #hiera_lookup(),
  $em_transactionevents_storage_max_disk_usage = 1024,  #hiera_lookup(),
  $em_metrics_live_limit = 500000,  #hiera_lookup(),
  $em_metrics_historical_limit = 1200000,  #hiera_lookup(),
  $em_agent_connection_limit = 400,   #hiera_lookup(),
  $em_disconnected_historical_agent_limit = 400,   #hiera_lookup(),
  $em_events_limit = 1250,  #hiera_lookup(),
  $em_agent_trace_limit = 1000,   #hiera_lookup(),
  $em_agent_error_limit = 10,   #hiera_lookup(),
  $apm_clw_max_users = 500,   #hiera_lookup(),
  $apm_workstation_max_users = 40,   #hiera_lookup(),
  $em_collector_cdv_max = 5,   #hiera_lookup(),
  $em_transaction_discovery_max_nonidentifying_components = 50,   #hiera_lookup(),
  $em_max_number_domain_configuration_changes = 0,   #hiera_lookup(),
  $em_max_transaction_user_groups = 5000,  #hiera_lookup(),
  $em_max_application_user_rows = 1000,  #hiera_lookup(),

  $owner  = $caapm::owner,
  $group  = $caapm::group,
  $mode   = $caapm::mode,
  $version = $caapm::version

){

  validate_absolute_path($em_home)

  $thresholds_config = "apm-events-thresholds-config.xml"

  file { $thresholds_config:
    ensure => present,
    force  => true,
    path    => "${em_home}/config/${thresholds_config}",
    content => template("${module_name}/${version}/${thresholds_config}"),
    owner   =>  $owner,
    group   =>  $group,
    mode    =>  $mode,
  }

}
