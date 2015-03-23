# Class: caapm::workstation
#
# This class manages the CA APM Workstation components archive and its accompanying End User License Agreement file, eula.txt. 
#
# Parameters:
# - $version the workstation version to download and install.
# - $install_dir the location to install the package.
# - $user the default user to display on the workstation login dialogue
# - $host the default host to display on the workstation login dialogue
# - $port the default port to display on the workstation login dialogue
class caapm::workstation (
  $version = $caapm::params::version,
  $install_dir = $caapm::params::install_dir,  
  $user = 'guest',
  $host = 'momhost',
  $port = $caapm::params::default_port,

) inherits caapm::params {
  
  require caapm::osgi
  
#  $user_install_dir = to_windows_escaped("${install_dir}")
#  $user_install_dir = "${install_dir}"
   $user_install_dir = $::operatingsystem ? {
    'windows' => to_windows_escaped("${install_dir}"),
    default  => "${install_dir}",
  }

  
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
  $eula_file = 'ca-eula.txt'
  $resp_file = 'Workstation.ResponseFile.txt'
    
  $puppet_src = "puppet:///modules/${module_name}/${version}"

  $resp_src = "${puppet_src}/${resp_file}"
  
  # determine the executable package  
  $pkg_bin = $::operatingsystem ? {
    'windows' => "IntroscopeWorkstation${version}windows.exe",
    default  => "IntroscopeWorkstation${version}unix.bin",
  }
  
  # download the eula.txt  
  staging::file { $eula_file:
    source => "${puppet_src}/${eula_file}",
    subdir => $staging_subdir,
  }  
/*
  -> file_line { 'Accept the eula.txt':
    path => "$::staging_windir/$staging_subdir/$eula_file",  
    line => 'CA-EULA=accept',
    match   => "^CA-EULA=.*$",
  }
*/
   
  # download the Workstation installer  
  staging::file { $pkg_bin:
    source => "${puppet_src}/${pkg_bin}",
    subdir => $staging_subdir,
    require => Staging::File[$eula_file],
    
  }
  
  # generate the response file
  file { $resp_file:
    path => "$::staging_windir/$staging_subdir/$resp_file",
    ensure => present,
    content => template("$module_name/$version/$resp_file"),
#    source_permissions => ignore,
    owner =>  $caapm::params::owner,
    group =>  $caapm::params::group,
    mode  =>  $caapm::params::mode,    
  }
    
  # install the Workstation package
  package { $pkg_name :
    ensure => "$version",
    source => "$::staging_windir\\$staging_subdir\\$pkg_bin",
    install_options => [" -f $::staging_windir\\$staging_subdir\\$resp_file"  ],
    require => [File[$resp_file], Staging::File[$pkg_bin]]
  }
  
}
