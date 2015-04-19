#
# == Class: caapm::params
#
# This call defines the defaults for ca apm installs
#

#
# TODO: make this pass on puppet-lint
#

class caapm::params (
) {

  include staging
  include stdlib

  $version = '9.1.4.0'
  $default_port = '5001'  # Port used by Enterprise Manager to listen for incoming connections.
  $ssl_port = '5443'      # Port used by Enterprise Manager for secure channel connections
  $web_port = '8081'      # Port used by Enterprise Manager to serve web applications.
  $webview_port = '8080'  # Port used by Enterprise Manager to serve WebView.
  $admin_passwd = ''      # Password for Enterprise Manager Admin account leave this entry blank to use default
  $guest_passwd = ''      # Password for Enterprise Manager Guest account leave this entry blank to use default
  $txntrace_days_to_keep = 14
  $txntrace_dir = 'traces'
  $txntrace_storage_cap = ''
  $smartstor_dir = 'data'
  $threaddump_dir = 'threaddumps'
  $em_host = "${::fqdn}"

}

