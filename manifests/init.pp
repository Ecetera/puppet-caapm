#
# == Class: caapm
#
# Puppet module to manage CA APM
#
# === Parameters
#
# === Variables
#
# === Examples
#
#

class caapm () {

  $version = '9.7.1.16'
  require staging


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
      $group  = 'root'
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
      $group  = 'Users'
      $mode   = '0644'
    }
  }

}
