
class caapm::agent::config inherits caapm::agent {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $notify_enabled {
    notify {"Running agent::config with version = $version":}
    notify {"Running agent::config with collector_groups = $collector_groups":}
    notify {"Running agent::config with assigned_collector_group = $assigned_collector_group":}
  }

  $profiles = ['WebSphere','Default']

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
      cwd       => "${agents_dir}/epagent/config",
      command   => '/bin/cp -p IntroscopeEPAgent.ppmanaged IntroscopeEPAgent.properties',
      notify    => Exec['logs_folder']
    }

    # ensure /var/caapm/logs exist; /app/caapm/epagent/logs links there
    exec { 'logs_folder':
      cwd     => "${agents_dir}",
      creates => "${logs_dir}",
      path    => '/bin:/usr/bin',
      command => "mkdir ${logs_dir}",
      user    => $owner,
      umask   => '0022',
      #notify  => Service['epagent']
    }


##Dev of ppwebserver##
#    exec { 'update_ppwebserver_properties':
#      cwd       => "${agents_dir}/ppwebserver/config",
#      command   => '/bin/cp -p WebServerAgent.ppmanaged WebServerAgent.profile',
#      notify    => Exec['logs_folder']????
#    }


#    ->
#    profile { $profiles: }


#  $profiles = ["BRTM","Default-OSGI","Default","HPJVM","Interstage","JBoss","SunOne","Tomcat-OSGI","Tomcat","WebLogic","WebSphere"]


#define profile (
#  $version = "${caapm::agent::version}",
#  $agents_dir = "${caapm::agent::agents_dir}",
#){
#  if $version == undef {
#          fail('Valid version not provided')
#  }
#
#  notify {"Running agent::config with ${name} profile":}
#
#  file { "applying ${name} profile":
#    ensure => present,
#    path   => "${agents_dir}/wily/core/config/IntroscopeAgent-${name}.ppmanaged",
#    force  => true,
#    content => template("${module_name}/${version}/agent/IntroscopeAgent-${name}.profile"),
#    owner  => $owner,
#    group  => $group,
#    mode   => $mode,
#    notify =>  Exec["updating ${name} profile"],
#  }
#
#  exec { "updating ${name} profile":
#    cwd         => "${agents_dir}/wily/core/config",
#    command     => "/bin/cp -p IntroscopeAgent-${name}.ppmanaged IntroscopeAgent-${name}.profile",
#    user        => $owner,
#  }
#}





}
