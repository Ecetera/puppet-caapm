# Class: caapm::params
#
# This class manages CA APM parameters.
#
# Parameters:
# - $em_home the installation directory for Introscope on your Enterprise Manager.
# - The $user CA APM runs as.
# - The $group CA APM is a member of.
class caapm::params (
) {
  
  # Based on the small number of inputs above, we can construct sane defaults
  # for pretty much everything else.

  # Settings common to everything
  $staging_subdir = 'caapm'

  # Settings common to a kernel
  case $::kernel {
    default: { fail("CA APM component does not support kernel ${kernel}") }
    'Linux': {
      $path_delimiter       = '/'
      $em_home = '/app/caapm/Introscope${osgiVersion}'
      $user_install_dir = '${em_home}'
      $em_service = [ 'Introscope Enterprise Manager ${version}'] 
      $wv_service = [ 'Introscope WebView ${version}']
      $em_confdir = '${em_home}/config'
    }
    'SunOS': {
      $path_delimiter       = '/'
      $forwarder_src_subdir = 'universalforwarder/solaris'
      $forwarder_service    = [ 'splunk' ]
      $forwarder_confdir    = '/opt/splunkforwarder/etc/system/local'
      $server_src_subdir    = 'splunk/solaris'
      $server_service       = [ 'splunk', 'splunkd', 'splunkweb' ]
      $server_confdir       = '/opt/splunk/etc/system/local'
    }
    'Windows': {
      $path_delimiter       = '\\'
      $em_home = 'D:/Apps/CA/APM/Introscope${osgiVersion}'
      $user_install_dir = 'D:\\\\Apps\\\\CA\\\\APM\\\\Introscope${version}\\\\'
      $em_service = [ 'Introscope Enterprise Manager ${version}'] 
      $wv_service = [ 'Introscope WebView ${version}']
      $em_confdir = '${em_home}/config'
      $pkg_provider = undef
      $src_permissions = ignore
    }
  }
  
  
  $user          = 'caapm'
  $group         = 'apm'
  
  $ca_eula    = 'accept'

/*  
  file {'${caapm::params::tempdir}':
    ensure => 'directory',
    owner  => '${caapm::params::user}',
    group  => '${caapm::params::group}',
    mode   => '${caapm::params::mode}',
  }
        
  
  
 */
  
}

