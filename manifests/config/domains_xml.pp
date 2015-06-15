class caapm::config::domains_xml (

  $em_home = $::caapm::em_home,
  $domains = undef,
  $owner  = $caapm::owner,
  $group  = $caapm::group,
  $mode   = $caapm::mode,
  $version = $caapm::version

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
