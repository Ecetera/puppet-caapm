
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

/*
    file { "oldtmp":
      ensure  => absent,
      path => "/tmp/IntroscopeAgentANZ10.0.0.12.tar.gz",
    }
 */
/*
 file { ["/etc/puppetlabs/facter","/etc/puppetlabs/facter/facts.d"]:
   ensure => directory,
 }->

    file { "/etc/puppetlabs/facter/facts.d/cluster.yaml":
      ensure  => file,
      content => "cluster: dev1\n",
    }->

    file { "/etc/puppetlabs/facter/facts.d/app.yaml":
      ensure  => file,
      content => "app: caapm\n",
    }
*/

  file {$agent_pkg:
    ensure => present,
    force  => true,
    path   => "${stage_dir}/${agent_pkg}",
    source => "${puppet_src}/agents/${agent_pkg}",
    owner  => $owner,
    group  => $group,
    mode   => $mode,
    links  => follow,
    notify =>  Exec["untar $agent_pkg"],
  }

  exec { "untar $agent_pkg":
    command   => "/bin/tar xfpz ${stage_dir}/${agent_pkg} -C ${agents_dir}",
    creates   => ["${agents_dir}/epagent", "${agents_dir}/wily", "${agents_dir}/ppwebserver", "${agents_dir}/APMCommandCenterController"],
    logoutput => true,
    returns   => [0,1],
    timeout   => 0,
    user      => $owner,
    group     => $group,
    umask     => '0022',
    require   => File[$agent_pkg],
  }


/*

  # Deploy Agent package
  deploy::file { $agent_pkg:
    target  => '/app/caapm',
    url     => "${puppet_src}/agents",
    owner   => $owner,
    group   => $group,
#    strip   => true,
  }

 */




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
