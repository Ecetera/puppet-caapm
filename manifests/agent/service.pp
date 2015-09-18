
class caapm::agent::service inherits caapm::agent {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

#  notify {"Running with em::service em_as_service = $em_as_service":}
#  notify {"Running with em::service wv_as_service = $wv_as_service":}


  file { 'epagent':
      ensure  => present,
      force   => true,
      path    => "/etc/init.d/epagent",
      content => template("${module_name}/init.d/epagent"),
      owner   =>  'root',
      group   =>  'root',
      mode    =>  '0755',
      notify  => Service['epagent']
  }

  service { 'epagent':
    ensure => true,
    enable => true,
  }



}
