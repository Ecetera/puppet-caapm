# 
# == Class: caapm::params
#
# This call defines the defaults for ca apm installs
#
class caapm::params (
) {

  include staging
  include stdlib
  
  $version = '9.1.4.0'
  $default_port = '5001'  # Port used by Enterprise Manager to listen for incoming connections.
  $ssl_port = '5443'      # Port used by Enterprise Manager for secure channel connections
  $web_port = '8081'      # Port used by Enterprise Manager to serve web applications.
  $webview_port = '8080'  # Port used by Enterprise Manager to serve WebView.
  $admin_passwd = ''      # Password for Enterprise Manager Admin account leave this entry blank to use default
  $guest_passwd = ''      # Password for Enterprise Manager Guest account leave this entry blank to use default
  $txntrace_days_to_keep = 14
  $txntrace_dir = 'traces'
  $txntrace_storage_cap = ''
  $smartstor_dir = 'data'
  $threaddump_dir = 'threaddumps'
  $em_host = "${::fqdn}"
  $apm_db = 'postgres'
  $db_host = 'localhost'
  $db_port = 5432
  $db_name = 'cemdb'
  $db_user_name = 'admin'
  $db_user_passwd = 'wily'
  $pg_dir = 'database'
  $pg_admin_user ='postgres'
  $pg_admin_passwd ='C@wilyapm90'
  $pg_install_timeout = 240000
  $pg_as_service = true

  $staging_subdir = "${module_name}"
  $accept_eula = 'accept'
  
  $ca_eula    = 'accept'
  $em_role = 'emc'


  # Settings common to a kernel
  case $::kernel {
    default: { fail("CA APM component does not support kernel ${::kernel}") }
    Linux, CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {
      $em_home = "/opt/caapm/Introscope${version}/"
      $user_install_dir = "${em_home}"
      $em_confdir = "${em_home}/config"
      $src_perms = ignore
      $pkg_provider = undef
      $src_permissions = ignore
      $owner  = 'root'
      $group  =  'root'
      $mode   = '0644'    
    }
    'Windows': {
      $em_home = "D:/Apps/CA/APM/Introscope${version}/"
      $user_install_dir = "D:/Apps/CA/APM/Introscope${version}/"
      $em_confdir = "${em_home}/config"
      $src_perms = ignore
      $pkg_provider = undef
      $src_permissions = ignore
      $owner  = 'Administrator'
      $group  =  'Users'
      $mode   = '0644'    
    }
  }
  
}

