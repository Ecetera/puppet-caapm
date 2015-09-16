
class caapm::agent::install inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }


  class { 'deploy':
      tempdir => $stage_dir,
  }

  if $notify_enabled {
    notify {"Running init with agent_pkg = $agent_pkg":}
  }

    file { "oldtmp":
      ensure  => absent,
      path => "/tmp/IntroscopeAgentANZ10.0.0.12.tar.gz",
    }


    file { "/etc/facter/facts.d/cluster.yaml":
      ensure  => file,
      content => "cluster: dev1\n",
    }

    file { "/etc/facter/facts.d/app.yaml":
      ensure  => file,
      content => "app: caapm\n",
    }

  # Deploy Java tar file
  deploy::file { $agent_pkg:
    target  => '/app/caapm',
    url     => "${puppet_src}/agents",
    owner   => $owner,
    group   => $group,
    strip   => true,
  }

  # download the required agents
  $agents = ["EPAgent","JavaAgent","MQMonitor","PPOracleDB","PPWebServers","SiteMinder_SNMP","TibcoEMSMonitor","WilyWMBrokerMonitor"]
#  $agents = ["epagent","wily","ppwebserver","pporacledb","mqmonitor"]

/*
  file {"${stage_dir}/IntroscopeAgentANZ${::version}-${build}.${::operatingsystem}.tar":
    ensure => present,
    force  => true,
    source => "${puppet_src}/${::version}/agents/${name}${version}${::operatingsystem}.tar",
    owner  => $owner,
    group  => $group,
    mode   => $mode,
    notify =>  Exec["${stage_dir}/IntroscopeAgentANZ${::version}-${build}.${::operatingsystem}.tar"],
  }

  exec { "${stage_dir}/IntroscopeAgentANZ${::version}-${build}.${::operatingsystem}.tar":
    command   => "/bin/tar xf ${stage_dir}/IntroscopeAgentANZ${::version}-${build}.${::operatingsystem}.tar -C ${agents_dir}",
    creates   => ["${agents_dir}/epagent", "${agents_dir}/wily", "${agents_dir}/ppwebserver"],
    logoutput => true,
    returns   => [0,1],
    timeout   => 0,
    user      => $owner,
  }


define resource {

  file {"${stage_dir}/${name}":
    ensure => present,
    force  => true,
    source => "${puppet_src}/${::version}/agents/${name}${version}${::operatingsystem}.tar",
    owner  => $owner,
    group  => $group,
    mode   => $mode,
    notify =>  Exec[$name],
  }

  exec { $name:
    command   => "/bin/tar ${stage_dir}/${name}${version}${::operatingsystem}.tar -C ${agents_dir}",
    creates   => "${agents_dir}/${name}",
    logoutput => true,
    returns   => [0,1],
    timeout   => 0,
    user      => $owner,
  }
}
  resource { $agents: }
 */

}
