
class caapm::em::service inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

#  notify {"Running with em::service em_as_service = $em_as_service":}
#  notify {"Running with em::service wv_as_service = $wv_as_service":}

  case $::operatingsystem {
    CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {

      if $em_as_service {

        # generate the SystemV init script
        file { $em_service_name:
          ensure  => present,
          force   => true,
          path    => "/etc/init.d/${em_service_name}",
          content => template("${module_name}/init.d/introscope"),
          owner   =>  'root',
          group   =>  'root',
          mode    =>  '0755',
          notify  => Service[$em_service_name],
        }

      }

      if $wv_as_service {
        file { $wv_service_name:
          ensure  => present,
          force   => true,
          path    => "/etc/init.d/${wv_service_name}",
          content => template("${module_name}/init.d/webview"),
          owner   =>  'root',
          group   =>  'root',
          mode    =>  '0755',
          require => [File['WVCtrl.sh'],Exec[$pkg_name]],
          notify  => Service[$wv_service_name]
        }

        # generate the WebView Control script
        file { 'WVCtrl.sh':
          ensure  => present,
          force   => true,
          path    => "${target_dir}/bin/WVCtrl.sh",
          source  => "${puppet_src}/bin/WVCtrl.sh",
          owner   => $owner,
          group   => $group,
          mode    => '0755',
          require => Exec[$pkg_name] ,
        }
      }
    }
    windows: {

    }
    default: {}

  }

  # ensure the service is running
  service { $em_service_name:
    ensure => $em_as_service,
    enable => $em_as_service,
  }

  service { $wv_service_name:
    ensure => $wv_as_service,
    enable => $wv_as_service,
  }

}
