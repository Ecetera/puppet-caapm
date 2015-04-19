#
# == Class: caapm::profile::standalone
#
# This profile configures the defaults for a standalone Enterprise Manager
#

#
# TODO: make this pass on puppet-lint
#

class caapm::profile::standalone {

#  $version = '9.1.4.0'
#  $version = '9.6.0.0'
#  $version = '9.7.0.27'
  $version = '9.7.1.16'

  case $::operatingsystem {

    CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {
      caapm::em {'*nx_standalone':
        version                     => "${version}",
        features                    => 'Enterprise Manager,WebView,Database',
        clusterEM                   => false,
        user_install_dir            => "/opt/caapm/Introscope${version}/",
        txnTraceDir                 => '/var/caapm/traces',
        smartstor_dir               => '/var/caapm/smartstor',
        threaddump_dir              => '/var/caapm/threaddumps',
        emLaxNlJavaOptionAdditional => '-Xms1024m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',
        database                    => 'postgres',
        postgres_dir                => '/opt/caapm/PostgreSQL/',
        em_service_name             => 'introscope',
        wv_service_name             => 'webview',
        config_em_as_service        => true,
        config_wv_as_service        => true,
        owner                       => 'root',
        group                       => 'root',
      }
    }

    windows: {
      caapm::em {'win_standalone':
        version                     => "${version}",
        features                    => 'Enterprise Manager,WebView,Database',
        clusterEM                   => false,
        user_install_dir            => "C:/Ecetera/Introscope${version}/",
        txnTraceDir                 => 'C:/Ecetera/traces',
        smartstor_dir               => 'C:/Ecetera/smartstor',
        threaddump_dir              => 'C:/Ecetera/threaddumps',
        emLaxNlJavaOptionAdditional => '-Xms1024m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',
        database                    => 'postgres',
        postgres_dir                => 'C:/Ecetera/PostgreSQL/',
        config_em_as_service        => true,
        config_wv_as_service        => true,
        owner                       => 'Administrator',
        group                       => 'Users'
      }
    }

    default: {}
  }

}
