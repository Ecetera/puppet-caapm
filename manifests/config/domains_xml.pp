class caapm::config::domains_xml (

  $em_home = undef,

  $domains = undef,

  $owner  = $caapm::params::owner,
  $group  = $caapm::params::group,
  $mode   = '0644',
  $version = '9.1.4.0',

){

  validate_absolute_path($em_home)

  $domains_xml = "domains.xml"

  file { $domains_xml:
    ensure => present,
    force  => true,
    path    => "${em_home}/config/${domains_xml}",
    content => template("${module_name}/${version}/${domains_xml}"),
    owner   =>  $owner,
    group   =>  $group,
    mode    =>  $mode,
  }

}
