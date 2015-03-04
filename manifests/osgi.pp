# Class: caapm::osgi
#
# This class manages the external components package archive and its accompanying End User License Agreement file, eula.txt. 
#
# Parameters:
# - $version the osgi version to download and install.
# - $souce_path the source location to obtain the files from.
#
class caapm::osgi (
  $version = $caapm::params::osgi_version,


)inherits caapm::params {
  
  include staging
  
/*  
  $version  = '9.1.4.0'
  $version  = '9.6.1.0'
  $version  = '9.7.0.0'
 */


  $eula  = 'accept'
  $eula_file = 'eula.txt'
  $osgisource = 'puppetmaster'

  $pkg_name = $::operatingsystem ? {
    'windows' => "osgiPackages.v${version}.windows.zip",
    default  => "osgiPackages.v${version}.unix.zip",
  }

  $pkg_source = $osgisource ? {
     'opensrcd' => "http://opensrcd.ca.com/ips/osgi/introscope_${version}",
      default => "puppet:///modules/${module_name}/${version}",
  } 
  
  $eula_src = "${pkg_source}/${eula_file}"
  $osgi_src = "$pkg_source/$pkg_name"
    
  staging::file { $eula_file:
    source => $eula_src,
    subdir => $staging_subdir,
  }
 
  staging::file { $pkg_name:
    source => $osgi_src,
    subdir => $staging_subdir,
    require => Staging::File[$eula_file],
  }
  
}
