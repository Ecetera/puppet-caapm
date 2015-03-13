# Class: caapm::workstation
#
# This class manages the CA APM Workstation components archive and its accompanying End User License Agreement file, eula.txt. 
#
# Parameters:
# - $version the workstation version to download and install.
# - $souce_path the source location to obtain the files from.
#
class caapm::workstation (

) inherits caapm::params {
  
  include caapm::osgi
  
  $version  = '9.1.4.0'
/*  
  $version  = '9.6.1.0'
  $version  = '9.7.0.0'
 */

  $features = ['Workstation']

  $eula  = 'accept'

  /*
Assume the following for consistency
  _src is what you download from puppet itself
  bin_src is the fqn for puppet:// with pkg_bin  
  pkg_bin is the installer.exe
  pkg_name for windows is the display name
  svc_name is name in services.msc
  
What do you set the above for this use case: workstation?
  pkg_bin = IntroscopeWorkstation${version}windows.exe
  bin_src = puppet://modules/caapm/$version/$pkg_bin
  pkg_name = "CA APM Workstation 9.1.4.0" 
  svc_name = IscopeEM
   */
  $pkg_name = "CA APM Introscope Workstation ${version}" 
  $ca_eula_file = 'ca-eula.txt'
  $eula_file = $ca_eula_file
#  $resp_file = 'SampleResponseFile.Workstation.txt'
  $resp_file = 'Workstation.ResponseFile.txt'
  
/*  $puppet_src = "$caapm::params::puppet_src/$version" */ 
  
  $puppet_src = "puppet:///modules/${module_name}/${version}"

  $eula_src = "${puppet_src}/${eula_file}"
  $resp_src = "${puppet_src}/${resp_file}"

    
  $pkg_bin = $::operatingsystem ? {
    'windows' => "IntroscopeWorkstation${version}windows.exe",
    default  => "IntroscopeWorkstation${version}unix.bin",
  }

  $pkg_src  = "${puppet_src}/${pkg_bin}"
    
  staging::file { $eula_file:
    source => $eula_src,
    subdir => $staging_subdir,
  }
 
  staging::file { $pkg_bin:
    source => $pkg_src,
    subdir => $staging_subdir,
    require => Staging::File[$eula_file],
  }
  
  staging::file { $resp_file:
    source => $resp_src,
    subdir => $staging_subdir,
    
/*    require => Staging::File[$pkg_name], */
  }
    
  notify {"package name is $pkg_name":}
    
  notify {"source is $::staging_windir\\$staging_subdir\\$pkg_bin":}

  notify {"install options is -f $::staging_windir\\$staging_subdir\\$resp_file":}
  
  package { $pkg_name :
    ensure => "$version",
    source => "$::staging_windir\\$staging_subdir\\$pkg_bin",
/*    install_options => ['-f ', ' $::staging_windir\\$staging_subdir\\$resp_file'], 
    install_options => [" -f ", " $resp_file"], */
    install_options => [" -f $::staging_windir\\$staging_subdir\\$resp_file"  ],
    require => Staging::File[$resp_file], 
  }
  
}
