
class caapm::agent::config inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

#  notify {"Running with agent::config":}

    file { "${agent_home}/epagent/config/IntroscopeEPAgent.ppmanaged":
      ensure  => present,
      content => template("${module_name}/${version}/IntroscopeEPAgent.properties"),
      owner   => $owner,
      group   => $group,
      mode    => $mode,
#      notify  => Exec['update_em_properties'],
    }
/*
    exec { 'update_em_properties':
      cwd         => "${agent_home}/epagent/config",
      command     => '/bin/cp -p IntroscopeEPAgent.ppmanaged /IntroscopeEPAgent.properties',
      refreshonly => true,
      notify  => Service['epagent'],
    }
 */



}
