
class caapm::em::service inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $em_as_service = ('Enterprise Manager' in $features) or $config_em_as_service
  $wv_as_service = ('WebView' in $features) or $config_wv_as_service
  $pg_as_service = ('Database' in $features)


  case $::operatingsystem {
    CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {

      # generate the SystemV init script
      file { $em_service_name:
        ensure  => present,
        force   => true,
        path    => "/etc/init.d/${em_service_name}",
        content => template("${module_name}/init.d/introscope"),
        owner   =>  $owner,
        group   =>  $group,
        mode    =>  '0744',
        notify  => Service[$em_service_name],
      }

      file { $wv_service_name:
        ensure  => present,
        force   => true,
        path    => "/etc/init.d/${wv_service_name}",
        content => template("${module_name}/init.d/webview"),
        owner   =>  $owner,
        group   =>  $group,
        mode    =>  '0744',
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
        mode    => '0744',
        require => Exec[$pkg_name] ,
      }

    }
    windows: {

    }
    default: {}

  }

  # ensure the service is running
  service { $em_service_name:
    ensure => $start_em_as_service,
    enable => $em_as_service,
  }

  service { $wv_service_name:
    ensure => $start_wv_as_service,
    enable => $wv_as_service,
  }

  service { 'postgres':
    ensure => $pg_as_service,
    enable => $pg_as_service,
  }

}
