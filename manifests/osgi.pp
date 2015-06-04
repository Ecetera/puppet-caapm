#
# == Class: caapm::osgi
#
# This class manages the external components package archive and its accompanying End User License Agreement file, eula.txt.
#
#

define caapm::osgi (
  $apmversion  = $title,
  $eula_file = undef,
  $pkg_name = undef,
  $osgisource = 'puppetmaster'

) {

  include staging

  $staging_subdir = $module_name
  $staging_path = $staging::path

  $version = $apmversion ? {
    '9.7.0.0' => '9.7.0.27',
    '9.7.1.0' => '9.7.1.16',
    default   => $apmversion,
  }


  $pkg_source = $osgisource ? {
    'opensrcd' => "http://opensrcd.ca.com/ips/osgi/introscope_${version}",
    default => "puppet:///modules/${module_name}/${version}",
  }

  $osgi_src = "${pkg_source}/${pkg_name}"

  # download the eula.txt
  staging::file { $eula_file:
    source => "${pkg_source}/${eula_file}",
    subdir => $staging_subdir,
  }


  # download the osgi package
  staging::file { $pkg_name:
    source  => "${pkg_source}/${pkg_name}",
    subdir  => $staging_subdir,
    require => Staging::File[$eula_file],
  }

}
