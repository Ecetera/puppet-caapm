#
# == Class: caapm
#
# Puppet module to manage CA APM
#
# === Parameters
#
# === Variables
#
# === Examples
#
#

class caapm (
    $version                       = $caapm::params::version,
    $appdir                        = $caapm::params::appdir,
    $vardir                        = $caapm::params::vardir,
    $em_home                       = $caapm::params::em_home,
    $min_heap                      = $caapm::params::min_heap,
    $max_heap                      = $caapm::params::max_heap,
    $threaddump_dir                = $caapm::params::threaddump_dir,
    $em_java_opts_addtl            = $caapm::params::em_java_opts_addtl,
    $postgres_dir                  = $caapm::params::postgres_dir,
    $pg_version                    = $caapm::params::pg_version,
    $pg_bin_dir                    = $caapm::params::pg_bin_dir,
    $pg_data_dir                   = $caapm::params::pg_data_dir,
    $em_properties                 = 'IntroscopeEnterpriseManager.properties',
    $smartstor_dir                 = $caapm::params::smartstor_dir,
    $smartstor_archive             = $caapm::params::smartstor_archive,
    $smartstor_dedicatedcontroller = false,
    $db_file                       = $caapm::params::db_file,
    $txnTraceDir                   = $caapm::params::txnTraceDir,
    $em_config_dir                 = $caapm::params::em_config_dir,
    $owner                         = 'caapm',
    $group                         = 'apm',
    $mode                          = '0744',
) inherits caapm::params {

  validate_absolute_path($em_home)

}
