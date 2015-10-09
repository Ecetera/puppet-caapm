class caapm::config::em_lax (

  $em_home = undef,
  
  $em_java_opts_addtl = '-Xms1024m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',

  $owner  = $caapm::params::owner,
  $group  = $caapm::params::group,
  $mode   = '0644',
  $version = '9.1.4.0',

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
