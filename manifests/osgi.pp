#
# == Class: caapm::osgi
#
# This class manages the external components package archive and its accompanying End User License Agreement file, eula.txt.
#
#

class caapm::osgi (
/*
  $apmversion  = $title,
  $eula_file = undef,
  $pkg_name = undef,
  $osgisource = 'puppetmaster'
 */
) inherits caapm {

  $osgiversion = $version ? {
    '9.7.0.0' => '9.7.0.27',
    '9.7.1.0' => '9.7.1.16',
    default   => $version,
  }

  $pkg_source = $osgisource ? {
    'opensrcd' => "http://opensrcd.ca.com/ips/osgi/introscope_${osgiversion}",
    default => "puppet:///modules/${module_name}/${osgiversion}",
  }

  $osgi_src = "${pkg_source}/${pkg_name}"

  # download the eula.txt
  file { $osgi_eula_file:
    ensure => present,
    force  => true,
    path   => "${stage_dir}/${osgi_eula_file}",
    source => "${puppet_src}/${version}/${osgi_eula_file}",
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  # download the osgi package
  file { $osgi_pkg_name:
    path   => "${stage_dir}/${osgi_pkg_name}",
    source => "${puppet_src}/${version}/${osgi_pkg_name}",
    owner   =>  $owner,
    group   =>  $group,
    mode    =>  $mode,
  }

}
