#
# == Class: caapm::profile::manager
#
# This profile configures the defaults for a Manager of Managers (MOM) Enterprise Manager
#

class caapm::profile::manager {

  $version                     = '9.7.1.16'
  $em_home                     = "/opt/caapm/Introscope${version}/"
  $owner                       = 'root'
  $group                       = 'root'
  $cluster_role                = 'MOM'


  caapm::em {'Manager':
    version                     => $version,
    user_install_dir            => $em_home,
    features                    => 'Enterprise Manager,WebView',
    clusterEM                   => true,
    cluster_role                => $cluster_role,
    txnTraceDir                 => '/var/caapm/traces',
    smartstor_dir               => '/var/caapm/smartstor',
    threaddump_dir              => '/var/caapm/threaddumps',
    emLaxNlJavaOptionAdditional => '-Xms1024m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',
    database                    => 'postgres',
    db_host                     => 'win28r2.diamond.org',
    em_service_name             => 'introscope',
    config_em_as_service        => true,
    wv_service_name             => 'webview',
    config_wv_as_service        => true,
  }

  class { 'caapm::config::wv_lax':
    version            => $version,
    em_home            => $em_home,
    owner              => $owner,
    group              => $group,
  }


}
