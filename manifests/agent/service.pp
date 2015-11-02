
class caapm::agent::service (

  # redhat variables
  $initDirectory      = '/etc/init.d',

  # solaris variables
  $manifestFile       = 'epagent.xml',
  $manifestDirectory  = '/app/caapm/manifest/application/apm',

) inherits caapm::agent {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

#  notify {"Operating System: ${::operatingsystem}":}

#  notify {"Running with em::service em_as_service = $em_as_service":}
#  notify {"Running with em::service wv_as_service = $wv_as_service":}

  case $::operatingsystem {

	  CentOS, RedHat: {

	    file { 'epagent':
		    ensure  => present,
		    force   => true,
		    path    => "${initDirectory}/epagent",
		    content => template("${module_name}/init.d/epagent"),
		    owner   =>  'root',
		    group   =>  'root',
		    mode    =>  '0755',
		    notify  => Service['epagent']
      }

#      service { 'RedHat service':
#        ensure      => true,
#        enable      => true,
#        hasstatus   => false,
#        hasrestart  => false,
#        start       => 'su -c "/app/caapm/epagent/bin/EPACtrl.sh start" -m caapm',
#        stop        => 'su -c "/app/caapm/epagent/bin/EPACtrl.sh stop" -m caapm'
#      }

	  }

	  Solaris: {

      exec { 'Validate Service':
        command   => 'svccfg validate epagent.xml',
        cwd       => $manifestDirectory,
#        onlyif    => 'test `svcs | grep -c epagent` -eq 0',
        logoutput => true,
        path      => $execPath,
        user      => 'root'
      }

      exec { 'Import Service':
        command   => 'svccfg import epagent.xml',
        cwd       => $manifestDirectory,
        logoutput => true,
        path      => $execPath,
        user      => 'root',
        require   => Exec['Validate Service'],
        notify    => Service['epagent']
      }

    }

  }

  service { 'epagent':
    ensure      => true,
    enable      => true,
#    hasstatus   => false,
    hasrestart  => false
  }

}
