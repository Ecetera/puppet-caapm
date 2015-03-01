# Class: caapm::osgi
#
# This class manages the external components package archive and its accompanying End User License Agreement file, eula.txt. 
#
# Parameters:
# - $version the osgi version to download and install.
# - $souce_path the source location to obtain the files from.
#
class caapm::osgi  {
  
  $version  = '9.1.4.0'
  $eula  = 'accept'

  
  $source_path = $::osgisource ? {
     'opensrcd' => 'http://opensrcd.ca.com/ips/osgi/introscope_${version}',
     default => 'puppet:///modules/${module_name}/${version}',
  } 
  
  $osgiPackageName = $::operatingsystem ? {
    'windows' => 'osgiPackages.v${version}.windows.zip',
    default  => 'osgiPackages.v${version}.unix.zip',
  }
  
  file {'eula.txt':
    ensure => file,
    path => '${caapm::params::tempdir}',
    
/*    path => '${apm::params::staging}/eula.txt', */
/*    source => 'puppet:///modules/${module_name}/${version}/eula.txt', */
    source => '${source_path}/eula.txt',
    require => File['${caapm::params::tempdir}'],
  }
  
  file {'${osgiPackageName}':
    ensure => file,
/*    path => '${stage_dir}/${osgiPackageName}', */
    source => '${source_path}/${osgiPackageName}',
    require => File['${caapm::params::tempdir}'],
  }
  
}