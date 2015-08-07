
class caapm::em::config inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

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

  file { "${em_home}/config/loadbalancing.xml":
    ensure  =>  present,
    content => template("${module_name}/${version}/loadbalancing.xml"),
    owner   => $owner,
    group   => $group,
    mode    => $mode,
  }


}
