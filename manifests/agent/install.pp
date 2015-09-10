
class caapm::agent::install inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # download the agents required agents
  $agents = ["EPAgent","JavaAgent","MQMonitor","PPOracleDB","PPWebServers","SiteMinder_SNMP","TibcoEMSMonitor","WilyWMBrokerMonitor"]


  file { $agents:
    ensure => present,
    force  => true,
    path   => "${stage_dir}",
    source => "${puppet_src}/${::version}/agents/${title}${version}${::operatingsystem}.tar",
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }


  validate_absolute_path($em_home)

  case $::operatingsystem {
    CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {
      exec { $agents:
        command   => "/bin/tar ${stage_dir}/${title}${version}${::operatingsystem}.tar ${stage_dir}/${pkg_bin} ${agents_dir}",
        creates   => "${agents_dir}/${title}",
        logoutput => true,
        returns   => [0,1],
        timeout   => 0,
        user      => $owner,
        require   => File[$agents],
      }

    }

    windows: {
      # install the agents using windows package
    }

    default: {}

  }

}
