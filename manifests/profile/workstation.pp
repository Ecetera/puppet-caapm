#
# == Class: caapm::profile::workstation
#
# This profile configures the defaults for a CA APM Workstation
#

class caapm::profile::workstation {

#  $version = '9.1.4.0'
#  $version = '9.6.0.0'
#  $version = '9.7.0.27'
  $version = '9.7.1.16'



  caapm::workstation {'apmws':
    version          => $version,
    user_install_dir => "D:/Apps/CA/APM/Introscope${::version}/",
  }


}
