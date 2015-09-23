
class caapm::agent::config inherits caapm::agent {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

    notify {"Running agent::config with notify_enabled = $notify_enabled":}

  if $notify_enabled {
    notify {"Running agent::config with version = $version":}
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
      notify  => Service['epagent'],
    }


#  $profiles = ["BRTM","Default-OSGI","Default","HPJVM","Interstage","JBoss","SunOne","Tomcat-OSGI","Tomcat","WebLogic","WebSphere"]
  $profiles = ["Websphere"]
/*
define profile (
  $version = "${caapm::agent::version}",
){
  if $version == undef {
          fail('Valid version not provided')
  }

  file { "applying ${name} profile":
    ensure => present,
    path   => "${agents_dir}/wily/core/config/IntroscopeAgent-${name}.ppmanaged",
    force  => true,
    content => template("${module_name}/${version}/agent/IntroscopeAgent-${name}.profile"),
    owner  => $owner,
    group  => $group,
    mode   => $mode,
    notify =>  Exec["updating ${name} profile"],
  }

  exec { "updating ${name} profile":
    cwd         => "${agents_dir}/wily/core/config",
    command     => "/bin/cp -p IntroscopeAgent-${name}.ppmanaged IntroscopeAgent-${name}.profile",
    user        => $owner,
  }
}

  profile { $profiles: }
*/


}
