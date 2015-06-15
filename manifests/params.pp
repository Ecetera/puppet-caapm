#
# == Class: caapm::params
#
# This call defines the defaults for ca apm installs
#

class caapm::params {
    $version                     = '9.7.1.27'
    $appdir                      = '/app/caapm'
    $vardir                      = '/var/caapm'
    $em_home                     = "${appdir}/Introscope${version}/"
    $min_heap                    = '1024m'
    $max_heap                    = '1024m'
    $threaddump_dir              = "${vardir}/threaddumps"
    $em_java_opts_addtl          = "-Xms${min_heap} -Xmx${max_heap} -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi"
    $postgres_dir                = "${appdir}/postgresql"
    $pg_version                  = '9.2'
    $pg_bin_dir                  = "${appdir}/postgresql/${pg_version}/bin"
    $pg_data_dir                 = "${appdir}/postgresql/data"
    #######################
    # SmartStor Settings
    #######################
    $smartstor_dir               = "${vardir}/smartstor"
    $smartstor_archive           = "${smartstor_dir}/archive"
    $db_file                     = "${smartstor_dir}/baselines.db"
    #######################
    # Transaction Event Database Settings
    #######################
    $txnTraceDir                 = "${vardir}/traces"
    $em_config_dir               = "${vardir}/config"
  
    case $::operatingsystem {
      CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {
        $owner = 'root'
        $group = 'root'
      }
      windows: {
        $owner = 'Administrator'
        $group = 'Users'
      }
      default: {
        $owner = 'default_user'
        $group = 'default_group'
      }
    }
}
