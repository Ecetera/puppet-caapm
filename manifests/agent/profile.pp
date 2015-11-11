
class caapm::agent::profile inherits caapm::agent {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $version == undef {
          fail('Valid version not provided')
  }

  notify {"Running agent::config with ${name} profile":}

  file { "applying ${name} profile":
    ensure => present,
    path   => "${agents_dir}/wily/core/config/IntroscopeAgent-${name}.ppmanaged",
    force  => true,
    content => template("${module_name}/${version}/agent/IntroscopeAgent-${name}.profile"),
    owner  => $::owner,
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
#    owner  => $::owner,
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
