#
# == Class: caapm::profile::standalone
#
# This profile configures the defaults for a standalone Enterprise Manager
#

#
# TODO: make this pass on puppet-lint
#

class caapm::profile::standalone {

  $version = '9.1.4.0'
#  $version = '9.6.0.0'
#  $version = '9.7.0.27'
#  $version = '9.7.1.16'

#  $upgrade_from_version = '9.7.0.27'

  caapm::em {'standalone':
    version => "${version}",
    features => 'Enterprise Manager,WebView,Database',
    clusterEM => false,
#    txnTraceDir => '/var/caapm/traces',
#    smartstor_dir => '/var/caapm/smartstor',
#    threaddump_dir => '/var/caapm/threaddumps',
    txnTraceDir => 'C:/Ecetera/traces',
    smartstor_dir => 'C:/Ecetera/smartstor',
    threaddump_dir => 'C:/Ecetera/threaddumps',
    emLaxNlJavaOptionAdditional => '-Xms1024m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',
#    emLaxNlJavaOptionAdditional => '-Xms1024m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=/var/caapm/config/esapi -Dcom.wily.introscope.em.properties=/var/caapm/config' ,
#    wvLaxNlJavaOptionAdditional => '-Xms128m -Xmx512m -Djava.awt.headless=true -Dorg.owasp.esapi.resources=/var/caapm/config/esapi -Dcom.wily.introscope.webview.properties=/var/caapm/config -Dsun.java2d.noddraw=true -XX:PermSize=128m -XX:MaxPermSize=256m',

    database => 'postgres',
#    postgres_dir => "/opt/caapm/PostgreSQL/",
    postgres_dir => "C:/Ecetera/PostgreSQL/",
    em_service_name => 'introscope',
    wv_service_name => 'webview',
    config_em_as_service => true,

# not upgrading
/* */
    upgradeEM => false,
#    user_install_dir => "/opt/caapm/Introscope${version}/",
    user_install_dir => "C:/Ecetera/Introscope${version}/",
/* */

# yes upgrading - use at your own risk
/*
    user_install_dir => "/opt/caapm/Introscope${upgrade_from_version}/",
    upgradeEM => true,
    upgraded_install_dir => "/opt/caapm/Introscope${version}/",
    upgrade_schema => true,
 */
  }

}
