# 
# == Class: caapm::role::apmdb
#
# This role designates the target as an APM DB 
#
class caapm::role::apmdb { 
  include caapm::profile::database
}