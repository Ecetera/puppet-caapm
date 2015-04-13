# 
# == Class: caapm::profile::database
#
# This profile configures the defaults for the PostgreSQL APM DB 
#
class caapm::profile::database { 

#  $version = '9.1.4.0'
#  $version = '9.6.0.0'
#  $version = '9.7.0.27'
  $version = '9.7.1.16'


  class { "caapm::database":
    version => "$version",
    user_install_dir => 'C:/Ecetera/Introscope/',
    database => 'postgres',
    postgres_dir => 'C:/Ecetera/PostgreSQL/',
  } 
}