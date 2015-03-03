# Class: caapm::workstation
#
# This class manages the CA APM Workstation components archive and its accompanying End User License Agreement file, eula.txt. 
#
# Parameters:
# - $version the workstation version to download and install.
# - $souce_path the source location to obtain the files from.
#
class caapm::workstation inherits caapm::params {
  
  include staging
  include caapm::osgi
  
  $version  = '9.1.4.0'
/*  
  $version  = '9.6.1.0'
  $version  = '9.7.0.0'
 */


  $eula  = 'accept'
  $eula_file = 'ca-eula.txt'
  $resp_file = 'SampleResponseFile.Workstation.txt' 

  $pkg_name = $::operatingsystem ? {
    'windows' => "IntroscopeWorkstation${version}windows.exe",
    default  => "IntroscopeWorkstation${version}unix.bin",
  }
  $pkg_source = "puppet:///modules/${module_name}/${version}"
  
  $eula_src = "${pkg_source}/${eula_file}"
  $pkg_src  = "${pkg_source}/${pkg_name}"
  $resp_src = "${pkg_source}/${resp_file}"
     
  staging::file { $eula_file:
    source => $eula_src,
    subdir => $staging_subdir,
  }
 
  staging::file { $pkg_name:
    source => $pkg_src,
    subdir => $staging_subdir,
    require => Staging::File[$eula_file],
  }
  
  staging::file { $resp_file:
    source => $resp_src,
    subdir => $staging_subdir,
    require => Staging::File[$pkg_name],
  }
  
}
