class caapm::config::em_lax (

  $em_home = $::caapm::em_home,
  $em_java_opts_addtl = $::caapm::em_java_opts_addtl,
  $owner  = $::caapm::owner,
  $group  = $::caapm::group,
  $mode   = $::caapm::mode,
  $version = $::caapm::version

){

  validate_absolute_path($em_home)

  $em_lax = "Introscope_Enterprise_Manager.lax"

  file { $em_lax:
    ensure => present,
    force  => true,
    path    => "${em_home}/${em_lax}",
    content => template("${module_name}/${version}/${em_lax}"),
    owner   =>  $owner,
    group   =>  $group,
    mode    =>  $mode,
  }

}
