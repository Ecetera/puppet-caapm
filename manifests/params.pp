#
# == Class: caapm::params
#
# This call defines the defaults for ca apm installs
#

class caapm::params () {

  case $::operatingsystem {
    CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {
      $owner = 'root'
      $group = 'root'
    }

    windows: {
      $owner = 'Administrator'
      $group = 'Users'
    }

    default: {
      $owner = 'default_user'
      $group = 'default_group'
    }
  }

}

