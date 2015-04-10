# 
# == Class: caapm::profile::crosscluster
#
# This profile configures the defaults for a cross-cluster viewer Enterprise Manager 
#
class caapm::profile::crosscluster { 
  class { "caapm::em":
    version                     => '9.1.4.0',
    user_install_dir            => 'C:/Ecetera/Introscope9.1.4.0/',
    features                    => 'Enterprise Manager',
    clusterEM                   => true,
    cluster_role                => 'CDV',
    txnTraceDir                 => 'C:/Ecetera/traces',
    smartstor_dir               => 'C:/Ecetera/smartstor',
    threaddump_dir              => 'C:/Ecetera/threaddumps',
    emLaxNlJavaOptionAdditional => '-Xms1024m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',
    database                    => 'postgres',
    db_host                     => 'win28r2.diamond.org',
    config_as_service           => true,
  }  
}