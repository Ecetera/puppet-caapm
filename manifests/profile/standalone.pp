class caapm::profile::standalone { 
  
#  $version = '9.1.4.0'
#  $version = '9.6.0.0'
#  $version = '9.7.0.27'
  $version = '9.7.1.16'
  
  
  class { "caapm::em":
    version => $version,
    user_install_dir => "/opt/caapm/Introscope${version}/",
    upgradeEM => false,
#    upgradeEM => true,
#    install_dir => '/opt/caapm/Introscope9.6.0.0/',
    features => 'Enterprise Manager,WebView,Database',
    clusterEM => false,
    txnTraceDir => '/var/caapm/traces',
    smartstor_dir => '/var/caapm/smartstor',
    threaddump_dir => '/var/caapm/threaddumps',
    emLaxNlJavaOptionAdditional => '-Xms1024m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',
    database => 'postgres',
    postgres_dir => "/opt/caapm/Introscope${version}/database",
    service_name => 'introscope',
    wv_service_name => 'webview',
    config_as_service => true,
  } 

}