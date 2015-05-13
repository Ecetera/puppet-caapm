#
# == Class: caapm::profile::collector
#
# This profile configures the defaults for a collector Enterprise Manager
#
class caapm::profile::collector {

  $version                     = '9.7.1.16'


  caapm::em {'collector':
    version                     => "${version}",
    user_install_dir            => "/opt/caapm/Introscope${version}/",
    features                    => 'Enterprise Manager',
    clusterEM                   => true,
    cluster_role                => 'Collector',
    txnTraceDir                 => '/var/caapm/traces',
    smartstor_dir               => '/var/caapm/smartstor',
    threaddump_dir              => '/var/caapm/threaddumps',
    emLaxNlJavaOptionAdditional => '-Xms1024m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',
    database                    => 'postgres',
    db_host                     => 'win28r2.diamond.org',
    em_service_name             => 'introscope',
    config_em_as_service        => true,
    owner                       => 'root',
    group                       => 'root',
  }

}
