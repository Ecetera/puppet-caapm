
class caapm::em::install inherits caapm {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  include caapm::osgi

  # download the eula.txt
  file { $eula_file:
    ensure => present,
    force  => true,
    path   => "${stage_dir}/${eula_file}",
    source => "${puppet_src}/${version}/${eula_file}",
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  # download the Enterprise Manager installer
  file { $pkg_bin:
    path   => "${stage_dir}/${pkg_bin}",
    source => "${puppet_src}/${version}/${pkg_bin}",
    owner   =>  $owner,
    group   =>  $group,
    mode    =>  '0544',
  }

  # generate the response file
  file { $resp_file:
    ensure  => present,
    force   => true,
    path    => "${stage_dir}/${resp_file}",
    content => template("${module_name}/${version}/${resp_file}"),
    owner   =>  $owner,
    group   =>  $group,
    mode    =>  $mode,
  }


  $install_options = $::operatingsystem ? {
    'windows' => "${stage_dir}\\${resp_file}",
    default   => "${stage_dir}/${resp_file}",
  }

  file { $failed_log :
    ensure => absent,
    path   => "${stage_dir}/${failed_log}",
    owner   =>  $owner,
    group   =>  $group,
    mode    =>  $mode,
  }


  validate_absolute_path($em_home)

    #new
/*
    file { "remove ${em_home}/logs":
      path    => "${em_home}/logs",
      ensure  => 'absent',
    }
*/
  file { $logs_dir:
    ensure  => 'directory',
    owner   => $owner,
    group   => $group,
    mode    => $mode,
  }


  case $::operatingsystem {
    CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {
      exec { $pkg_name :
#        command     => "$staging_path/$staging_subdir/$pkg_bin -f $install_options;cat $staging_path/$staging_subdir/silent.install.failed.txt;true",
        command   => "${stage_dir}/${pkg_bin} -f ${install_options}",
        creates => $features ? {
          'Database' => $postgres_dir,
          default  => "${em_home}launcher.jar",
        },
        require   => [Class[caapm::osgi],File[$resp_file], File[$pkg_bin], File[$failed_log]],
        logoutput => true,
        returns   => [0,1],
        timeout   => 0,
        user      => $owner,
#        before    => File[$lic_file],
      }

      file { "${em_home}/logs":
        ensure  => 'link',
        target  => $logs_dir,
#      before  => File["remove ${em_home}/logs"],
        require => File[$logs_dir],
      }

    }

    windows: {
      # install the Enterprise Manager package
      package { $pkg_name :
        ensure          => $version,
        source          => "${stage_dir}/${pkg_bin}",
        install_options => [" -f ${install_options}" ],
#        require         => [Caapm::Osgi[$version], File[$resp_file], File[$pkg_bin], File[$failed_log]],
        require         => [Class[caapm::osgi],File[$resp_file], File[$pkg_bin], File[$failed_log]],
        notify          => [Service[$em_service_name], Service[$wv_service_name]],
        allow_virtual   => true,
#        before          => File[$lic_file],
      }
    }

    default: {}

  }


}
