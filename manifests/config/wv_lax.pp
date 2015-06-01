class caapm::config::wv_lax (

  $em_home = undef,

  $wv_java_opts_addtl = 'Xms128m -Xmx512m -Djava.awt.headless=true -Dorg.owasp.esapi.resources=./config/esapi',

  $owner  = $caapm::params::owner,
  $group  = $caapm::params::group,
  $mode   = '0644',
  $version = '9.1.4.0',

){

  validate_absolute_path($em_home)

  $wv_lax = "Introscope_WebView.lax"

  file { $wv_lax:
    ensure => present,
    force  => true,
    path    => "${em_home}/${wv_lax}",
    content => template("${module_name}/${version}/${wv_lax}"),
    owner   =>  $owner,
    group   =>  $group,
    mode    =>  $mode,
  }

}
