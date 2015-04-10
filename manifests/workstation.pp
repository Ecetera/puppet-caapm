# 
# == Class: caapm::workstation
#
# Downloads from file folder and install ca apm workstation with a silent install on linux and windows servers
#
#
# Parameters:
# - $version the workstation version to download and install.
# - $install_dir the location to install the package.
# - $user the default user to display on the workstation login dialogue
# - $host the default host to display on the workstation login dialogue
# - $port the default port to display on the workstation login dialogue
class caapm::workstation (
  $version = $caapm::params::version,
  $user_install_dir = $caapm::params::user_install_dir,  
  $user = 'Admin',
  $host = 'momhost',
  $port = $caapm::params::default_port,

) inherits caapm::params {
  
  class { "caapm::osgi":
    apmversion => $version,
  }
  
  $staging_path = $staging::params::path 
  
  $user_install_dir_em = $::operatingsystem ? {
    'windows' => to_windows_escaped("${user_install_dir}"),
    default  => "${user_install_dir}",
  }

  
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

   
  # download the Workstation installer  
  staging::file { $pkg_bin:
    source => "${puppet_src}/${pkg_bin}",
    subdir => $staging_subdir,
    require => Staging::File[$eula_file],
    
  }
  
  # generate the response file
  file { $resp_file:
    path => "$staging_path/$staging_subdir/$resp_file",
    ensure => present,
    content => template("$module_name/$version/$resp_file"),
#    source_permissions => ignore,
    owner =>  $caapm::params::owner,
    group =>  $caapm::params::group,
    mode  =>  $caapm::params::mode,    
  }
  
  $install_options = $::operatingsystem ? {
    'windows' => "$staging_path\\$staging_subdir\\$resp_file",
    default   => "$staging_path/$staging_subdir/$resp_file",
  }
  
  
    
  # install the Workstation package
  package { $pkg_name :
    ensure => "$version",
    source => "$staging_path\\$staging_subdir\\$pkg_bin",
    install_options => [" -f $install_options"  ],
    require => [File[$resp_file], Staging::File[$pkg_bin]]
  }
  
}
