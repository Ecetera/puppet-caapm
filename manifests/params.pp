# Class: caapm::params
#
# This class manages CA APM parameters.
#
# Parameters:
# - $em_home the installation directory for Introscope on your Enterprise Manager.
# - The $user CA APM runs as.
# - The $group CA APM is a member of.
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

