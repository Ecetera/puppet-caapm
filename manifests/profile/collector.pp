class caapm::profile::collector { 
  class { "caapm::em":
    version => '9.1.4.0',
    install_dir => '/opt/caapm/Introscope9.1.4.0/',
    features => 'Enterprise Manager',
    clusterEM => true,
    cluster_role => 'Collector',
    txnTraceDir => '/opt/caapm/traces',
    smartstor_dir => '/opt/caapm/smartstor',
    threaddump_dir => '/opt/caapm/threaddumps',
    emLaxNlJavaOptionAdditional => '-Xms1024m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',
    database => 'postgres',
    db_host => 'win28r2.diamond.org',
    service_name => 'introscope',
    config_as_service => true,
  } 
  
}