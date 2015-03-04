# Class: caapm
#
# This module manages caapm
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class caapm (
  $em_role = $caapm::params::em_role,  /* standalone, emc, mom, cdv, tcs */
  $em_home = $caapm::params::em_home,  /* override if needed */
  $version = $caapm::params::apm_version,  
  $accept_ca_eula = $caapm::params::accept_eula,
  $accept_osgi_eula = $caapm::params::accept_eula,

  $user       = $caapm::params::user,
  $group      = $caapm::params::group,
  

  
) inherits caapm::params {
    $version      = '9.1.4.0'
  

}
