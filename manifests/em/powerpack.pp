define powerpack (
  $em_home = "${caapm::em_home}",
){

  notify {"Running em::powerpack with ${name} powepack":}

/*
  if $version == undef {
    fail('Valid version not provided')
  }


  file { "applying ${name} powerpack":
    ensure => directory,
    path   => $em_home,
    recurse => remote,
    source => "${em_home}/examples/${name}",
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }
 */
}
