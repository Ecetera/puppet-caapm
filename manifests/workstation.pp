#
# == Define: caapm::workstation
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

define caapm::workstation (
  $version          = '9.1.4.0',
  $user_install_dir = undef,
  $user             = 'Admin',
  $host             = 'momhost',
  $port             = '5001',

  $owner  = 'Administrator',
  $group  = 'Users',
  $mode   = '0655',

  $puppet_src = "puppet:///modules/${module_name}"

){

  require staging

  $staging_subdir = $module_name
  $staging_path = $staging::params::path


  $user_install_dir_em = $::operatingsystem ? {
    'windows' => to_windows_escaped($user_install_dir),
    default  => $user_install_dir,
  }

  $osgi_eula_file = 'eula.txt'
  $osgi_pkg_name  = $::operatingsystem ? {
    'windows' => "osgiPackages.v${version}.windows.zip",
    default   => "osgiPackages.v${version}.unix.tar",
  }

  caapm::osgi { $version:
    eula_file => $osgi_eula_file,
    pkg_name  => $osgi_pkg_name
  }


  $pkg_name = "CA APM Introscope Workstation ${version}"
  $eula_file = 'ca-eula.txt'
  $resp_file = 'Workstation.ResponseFile.txt'
  $failed_log = 'silent.install.failed.txt'

  # determine the executable package
  $pkg_bin = $::operatingsystem ? {
    'windows' => "IntroscopeWorkstation${version}windows.exe",
    default   => "IntroscopeWorkstation${version}unix.bin",

  }

  # download the eula.txt
  file { $eula_file:
    ensure => present,
    force  => true,
    path   => "${staging_path}/${staging_subdir}/${eula_file}",
    source => "${puppet_src}/${version}/${eula_file}",
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  # download the Workstation installer
  staging::file { $pkg_bin:
    source => "${puppet_src}/${version}/${pkg_bin}",
    subdir => $staging_subdir,
  }

  # generate the response file
  file { $resp_file:
    ensure  => present,
    force   => true,
    path    => "${staging_path}/${staging_subdir}/${resp_file}",
    content => template("${module_name}/${version}/${resp_file}"),
    owner   => $owner,
    group   => $group,
    mode    => $mode,
  }

  $install_options = $::operatingsystem ? {
    'windows' => "${staging_path}\\${staging_subdir}\\${resp_file}",
    default   => "${staging_path}/${staging_subdir}/${resp_file}",
  }

  file { $failed_log :
    ensure => absent,
    path   => "${staging_path}/${staging_subdir}/${failed_log}",
  }

  # install the Workstation package
  package { $pkg_name:
    ensure          => $version,
    source          => "${staging_path}\\${staging_subdir}\\${pkg_bin}",
    install_options => [" -f ${install_options}"],
    require         => [Caapm::Osgi[$version], File[$resp_file], Staging::File[$pkg_bin], File[$failed_log]]
  }

}
