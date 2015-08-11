#
# == Class: caapm::profile::collector
#
# This profile configures the defaults for a collector Enterprise Manager
#
class caapm::profile::collector {

  $version                     = '9.7.1.16'
  $em_home                     = "/opt/caapm/Introscope${version}/"
  $db_host                     = 'win28r2.diamond.org'
  $cluster_role                = 'Collector'
  $em_service_name             = 'introscope'
  $config_em_as_service        = true
  $owner                       = 'root'
  $group                       = 'root'
  $em_java_opts_addtl          = '-Xms512m -Xmx512m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi'
  $puppet_src                  = "puppet:///modules/${module_name}"


  caapm::em {'collector':
    version                     => $version,
    user_install_dir            => $em_home,
    features                    => 'Enterprise Manager',
    clusterEM                   => true,
    cluster_role                => $cluster_role,
    emLaxNlJavaOptionAdditional => $em_java_opts_addtl,
    database                    => 'postgres',
    db_host                     => $db_host,
    em_service_name             => $em_service_name,
    config_em_as_service        => $config_em_as_service,
    owner                       => $owner,
    group                       => $group,
    notify                      => [ Class['caapm::config::em_lax'],
                                     Class['caapm::config::em_properties'],
                                     Class['caapm::config::apm_events_thresholds'],
                                     Class['caapm::config::domains_xml'],
                                     File['IntroscopeHelp.war']]
  }
  ->
  tidy { ["$em_home/config/modules"]:
    recurse => true,
    rmdirs  => true,
  }
  ->
  file { ["$em_home/config/modules", "$em_home/webapps"]:
    ensure  => directory,
    owner   => $owner,
    group   => $group,
  }



  class { 'caapm::config::em_lax':
    version            => $version,
    em_home            => $em_home,
    em_java_opts_addtl => $em_java_opts_addtl,
    owner              => $owner,
    group              => $group,
  }

  class { 'caapm::config::em_properties':
    version                     => $version,
    em_home                     => $em_home,
    cluster_role                => $cluster_role,
    transactionevents_dir       => '/var/caapm/traces',
    smartstor_dir               => '/var/caapm/smartstor',
    threaddump_dir              => '/var/caapm/threaddumps',
    smartstor_archive           => '/var/caapm/smartstor/archive',
    baselines_dir               => '/var/caapm/smartstor',
#    soa_deviation_enabled       => true,
    owner                       => $owner,
    group                       => $group,
  }

  class { 'caapm::config::apm_events_thresholds':
    version => $version,
    em_home => $em_home,
    owner   => $owner,
    group   => $group,
  }

  file { 'IntroscopeHelp.war':
    ensure  => present,
    force   => true,
    path    => "${em_home}/webapps/IntroscopeHelp.war",
    source  => "${puppet_src}/${version}/IntroscopeHelp.war",
    owner   => $owner,
    group   => $group,
  }

  class { 'caapm::config::domains_xml':
    version => $version,
    em_home => $em_home,
    owner   => $owner,
    group   => $group,
  }

}
