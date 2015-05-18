#
# == Class: caapm::profile::collector
#
# This profile configures the defaults for a collector Enterprise Manager
#
class caapm::profile::collector {

  $version                     = '9.7.1.16'
  $em_home                     = "/opt/caapm/Introscope${version}/"
  $db_host                     = 'win28r2.diamond.org'
  $em_service_name             = 'introscope'
  $config_em_as_service        = true
  $owner                       = 'root'
  $group                       = 'root'
  $em_java_opts_addtl          = '-Xms512m -Xmx512m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi'


  caapm::em {'collector':
    version                     => $version,
    user_install_dir            => $em_home,
    features                    => 'Enterprise Manager',
    clusterEM                   => true,
    emLaxNlJavaOptionAdditional => $em_java_opts_addtl,
    database                    => 'postgres',
    db_host                     => $db_host,
    em_service_name             => $em_service_name,
    config_em_as_service        => $config_em_as_service,
    start_em_as_service         => false,
    owner                       => $owner,
    group                       => $group,
  }

  # establish dependency order
  ->
  class { 'caapm::config::em_lax':
    version            => $version,
    em_home            => $em_home,
    em_java_opts_addtl => $em_java_opts_addtl,
    owner              => $owner,
    group              => $group,
  }
  ->
  class { 'caapm::config::em_properties':
    version                     => $version,
    em_home                     => $em_home,
    cluster_role                => 'Collector',
    transactionevents_dir       => '/var/caapm/traces',
    smartstor_dir               => '/var/caapm/smartstor',
    threaddump_dir              => '/var/caapm/threaddumps',
    smartstor_archive           => '/var/caapm/smartstor/archive',
    baselines_dir               => '/var/caapm/smartstor',
#    snmp_enable                 => true,
#    scauth_enable               => true,
#    catalyst_snmp_enable        => true,
#    catalyst_snmp_destination_host => 'redhat1',
    owner                       => $owner,
    group                       => $group,
  }
  ->
  class { 'caapm::config::apm_events_thresholds':
    version => $version,
    em_home => $em_home,
    owner   => $owner,
    group   => $group,
  }

}
