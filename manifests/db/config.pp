
class caapm::db::config inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

#  notify {"Running with db::config pg_as_service = $pg_as_service":}

/*
  file {  "${em_home}/bin/Introscope_Enterprise_Manager.lax":
    ensure  =>  present,
    content => template("${module_name}/${version}/Introscope_Enterprise_Manager.lax"),
    owner   => $owner,
    group   => $group,
    mode    => $mode,
  }

  file { "${em_home}/config/IntroscopeEnterpriseManager.properties":
    ensure  => present,
    content => template("${module_name}/${version}/IntroscopeEnterpriseManager.properties"),
    owner   => $owner,
    group   => $group,
    mode    => $mode,
  }

  file { "${em_home}/config/IntroscopeWebView.properties":
    ensure  => present,
    content => template("${module_name}/${version}/IntroscopeWebView.properties"),
    owner   => $owner,
    group   => $group,
    mode    => $mode,
  }

  file {  "${em_home}/bin/Introscope_WebView.lax.lax":
    ensure  =>  present,
    content => template("${module_name}/${version}/Introscope_WebView.lax"),
    owner   => $owner,
    group   => $group,
    mode    => $mode,
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
  }

  file { "${em_home}/config/tess-db-cfg.xml":
    ensure =>  present,
    content => template("${module_name}/${version}/tess-db-cfg.xml"),
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  file_line { 'set_db_passwd':
    path  => "${em_home}/config/tess-db-cfg.xml",
    line  => "<property name=\"hibernate\.connection\.password\">${db_user_passwd}</property>",
    match => "<property name=\"hibernate\.connection\.password\">.*</property>",
  } ->

  file_line { 'reset_db_plaintextpasswords':
    path  => "${em_home}/config/tess-db-cfg.xml",
    line  => "<property name=\"plainTextPasswords\">true</property>",
    match => "<property name=\"plainTextPasswords\">false</property>",
  }


  file { "${em_home}/config/loadbalancing.xml":
    ensure  =>  present,
    content => template("${module_name}/${version}/loadbalancing.xml"),
    owner   => $owner,
    group   => $group,
    mode    => $mode,
  }

  file { 'IntroscopeHelp.war':
    ensure  => present,
    force   => true,
    path    => "${em_home}/webapps/IntroscopeHelp.war",
    source  => "${puppet_src}/${version}/IntroscopeHelp.war",
    owner   => $owner,
    group   => $group,
  }

 */



}
