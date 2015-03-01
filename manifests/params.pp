# Class: tomcat::params
#
# This class manages Tomcat parameters.
#
# Parameters:
# - $catalina_home is the root of the Tomcat installation.
# - The $user Tomcat runs as.
# - The $group Tomcat runs as.
class caapm::params {
  $user          = 'caapm'
  $group         = 'apm'
  
  $ca_eula    = 'accept'

  $em_home = $::operatingsystem ? {
    'windows' => 'D:/Apps/CA/APM/Introscope${::osgiVersion}',
    default  => '/app/caapm/Introscope${osgiVersion}',
  }
  
  $user_install_dir = $::operatingsystem ?{
    'windows' => 'D:\\\\Apps\\\\CA\\\\APM\\\\Introscope${::osgiVersion}\\\\',
    default  => $em_home,
  }

  $tempdir = $::operatingsystem ?{
    'windows' => 'D:/Temp',
    default  => '/tmp',
  }
  
  file {'${caapm::params::tempdir}':
    ensure => 'directory',
    owner  => '${caapm::params::user}',
    group  => '${caapm::params::group}',
    mode   => '${caapm::params::mode}',
  }
        
  
  

  
}

