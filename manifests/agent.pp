#
# == Define: caapm::database
#
# This installs the CA APM Database PostgreSQL Bundle
#
#

class caapm::agent (


  $version                 = $::caapm::version,

  $owner                   = $::caapm::owner,
  $group                   = $::caapm::group,
  $mode                    = $::caapm::mode,

  $puppet_src = "puppet:///modules/${module_name}"

){


  include caapm::agent::install
  include caapm::agent::config
  include caapm::agent::service

  Class['caapm::agent::install'] ->
  Class['caapm::agent::config']  ->
  Class['caapm::agent::service']

  anchor {
    'caapm::begin':
       before  => Class['caapm::agent::install','caapm::agent::config'],
       notify  => Class['caapm::agent::service'];
    'caapm::end':
       require => Class['caapm::agent::service'];
  }

}
