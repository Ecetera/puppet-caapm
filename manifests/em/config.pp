
class caapm::em::config inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $notify_enabled {
    notify {"Running with em::config em_as_service = $em_as_service":}
    notify {"Running with em::config wv_as_service = $wv_as_service":}
    notify {"Running with em::config collectors = $collectors":}
  }

  notify {"Running with em::config powerpacks = $powerpacks":}
  powerpack { $powerpacks: }

  if $em_as_service {

    if versioncmp($version, '9.6.0.0' ) < 0 {
      file { $lic_file:
        ensure =>  present,
        source => "${puppet_src}/license/${lic_file}",
        path   => "${em_home}license/${lic_file}",
        owner  => $owner,
        group  => $group,
        mode   => $mode,
      }
    }

    file {  "${em_home}/Introscope_Enterprise_Manager.lax":
      ensure  =>  present,
      content => template("${module_name}/${version}/Introscope_Enterprise_Manager.lax"),
      owner   => $owner,
      group   => $group,
      mode    => $mode,
    }

# may need to manage an interim file.  copy over if there are major changes beyond plaintextpassword=true
    file { "${em_home}/config/IntroscopeEnterpriseManager.ppmanaged":
      ensure  => present,
      content => template("${module_name}/${version}/IntroscopeEnterpriseManager.properties"),
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      notify  => Exec['update_em_properties'],
    }

    exec { 'update_em_properties':
      cwd         => "${em_home}/config",
      command     => '/bin/cp -p IntroscopeEnterpriseManager.ppmanaged IntroscopeEnterpriseManager.properties',
      refreshonly => true,
#      notify  => Service[$em_service_name],
    }

    file { "${em_home}/config/apm-events-thresholds-config.xml":
      ensure =>  present,
      content => template("${module_name}/${version}/apm-events-thresholds-config.xml"),
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }

    file { "${em_home}/config/domains.xml":
      ensure =>  present,
      content => template("${module_name}/${version}/domains.xml"),
      owner  => $owner,
      group  => $group,
      mode   => $mode,
      notify  => Service[$em_service_name],
    }

    file { "${em_home}/config/tess-db-cfg.ppmanaged":
      ensure =>  present,
      content => template("${module_name}/${version}/tess-db-cfg.xml"),
      owner  => $owner,
      group  => $group,
      mode   => $mode,
      notify  => Exec['update_tess_db_cfg'],
    }

    exec { 'update_tess_db_cfg':
      cwd         => "${em_home}/config",
      command     => '/bin/cp -p tess-db-cfg.ppmanaged tess-db-cfg.xml',
      refreshonly => true,
      notify  => Service[$em_service_name],
    }

    if $pg_ssl {

      file_line { 'enable_https_introscope':
        path    => "${em_home}/config/em-jetty-config.xml",
        line    => "<Set name=\"port\">${web_port}</Set>${web_ciphersuites}",
        match   => "<Set name=\"port\">8444</Set>(.*)",
      }

    }

  }

  if $wv_as_service {

    file { "${em_home}/config/IntroscopeWebView.properties":
      ensure  => present,
      content => template("${module_name}/${version}/IntroscopeWebView.properties"),
      owner   => $owner,
      group   => $group,
      mode    => $mode,
    }


    file {  "${em_home}/Introscope_WebView.lax":
      ensure  =>  present,
      content => template("${module_name}/${version}/Introscope_WebView.lax"),
      owner   => $owner,
      group   => $group,
      mode    => $mode,
    }

    if $pg_ssl {

      file_line { 'enable_https_webview':
        path    => "${em_home}/config/webview-jetty-config.xml",
        line    => "<Set name=\"port\">${webview_port}</Set>${web_ciphersuites}",
        match   => "<Set name=\"port\">8443</Set>(.*)",
      }

    }
  }

}
