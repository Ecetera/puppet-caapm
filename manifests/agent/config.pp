
class caapm::agent::config inherits caapm::agent {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $notify_enabled {
    notify {"Running agent::config with collector_groups = $collector_groups":}
    notify {"Running agent::config with assigned_collector_group = $assigned_collector_group":}
  }



#  notify {"Running with agent::config":}

    file { "${agents_dir}/epagent/config/IntroscopeEPAgent.ppmanaged":
      ensure  => present,
      content => template("${module_name}/${version}/agent/IntroscopeEPAgent.properties"),
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      notify  => Exec['update_epagent_properties'],
    }

    exec { 'update_epagent_properties':
      cwd         => "${agents_dir}/epagent/config",
      command     => '/bin/cp -p IntroscopeEPAgent.ppmanaged IntroscopeEPAgent.properties',
#      refresh     => true,
      notify  => Service['epagent'],
    }




}
