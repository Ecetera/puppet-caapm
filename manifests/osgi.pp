# Class: caapm::osgi
#
# This class manages the external components package archive and its accompanying End User License Agreement file, eula.txt. 
#
# Parameters:
# - $version the osgi version to download and install.
# - $souce_path the source location to obtain the files from.
#
class caapm::osgi (
  $apmversion  = '9.1.4.0',

  $osgisource = 'puppetmaster'
)inherits caapm::params {
  
  include staging

  $version = $apmversion ? {
    '9.7.0.0' => '9.7.0.27',
    '9.7.1.0' => '9.7.1.16',
    default   => $apmversion,
  }  
  $eula_file = 'eula.txt'
  
  # determine osgi package
  $pkg_name = $::operatingsystem ? {
    'windows' => "osgiPackages.v${version}.windows.zip",
    default  => "osgiPackages.v${version}.unix.tar",
  }
  
  $osgi_pkg_name = $pkg_name

  $pkg_source = $osgisource ? {
     'opensrcd' => "http://opensrcd.ca.com/ips/osgi/introscope_${version}",
      default => "puppet:///modules/${module_name}/${version}",
  } 
  
  $osgi_src = "$pkg_source/$pkg_name"
  
  # download the eula.txt  
  staging::file { $eula_file:
    source => "${pkg_source}/${eula_file}",
    subdir => $staging_subdir,
  }
 
  # download the osgi package
  staging::file { $pkg_name:
    source => "$pkg_source/$pkg_name",
    subdir => $staging_subdir,
    require => Staging::File[$eula_file],
  }
  
}
