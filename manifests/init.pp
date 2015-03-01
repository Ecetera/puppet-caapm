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
  $ca_eula    = $caapm::params::ca_eula,
  $osgi_eula  = $caapm::osgi::eula,
  $user       = $caapm::params::user,
  $group      = $caapm::params::group,
  

  
) inherits caapm::params {

}
