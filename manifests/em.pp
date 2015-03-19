# Class: caapm::em
#
# This class manages the Enterprise Manager archive and its accompanying End User License Agreement file, eula.txt. 
#
# Parameters:
# - $version the osgi version to download and install.
# - $souce_path the source location to obtain the files from.
#
class caapm::em (
  $version = $caapm::params::version,
  $install_dir = $caapm::params::version,  
  $features = 'Enterprise Manager,WebView',
  
  # Enterprise Manager Upgrade toggle
  $upgradeEM = false,
  
  # Enteprise Manager Ports Settings
  $default_port = $caapm::params::default_port,
  $ssl_port = $caapm::params::ssl_port,
  $web_port = $caapm::params::web_port,
  
  # Enterprise Manager User Password Settings
  $admin_passwd = $caapm::params::admin_passwd,
  $guest_passwd = $caapm::params::guest_passwd,
  
  # Enterprise Manager Clustering Settings
  $clusterEM = false,        # Set to true if this Enterprise Manager will participate in a cluster.
  $cluster_role = '',         # Specify clustering role for this EM. Valid values are "Collector", "Manager" or "CDV"
  
  # Enterprise Manager Transaction Storage Settings
  $txnTraceDataShelfLife = $caapm::params::txntrace_days_to_keep,
  $txnTraceDir = $caapm::params::txntrace_dir,
  $txnTraceDiskSpaceCap = $caapm::params::txntrace_storage_cap,
  
  # Enterprise Manager SmartStor Settings
  $smartstor_dir = $caapm::params::smartstor_dir,

  # Enterprise Manager Thread Dump Settings
  $threaddump_dir = $caapm::params::threaddump_dir,
   
  # CA APM Powerpack and Integrations toggle
  $enable_ADA = true,         #CA APM Integration for Application Delivery Analysis
  $enable_OracleDB = false,         #CA APM for Oracle Databases
  $enable_SharePointPortal = false,         #CA APM for Microsoft SharePoint
  $enable_WebServers = false,         #CA APM for Web Servers 
  $enable_WebLogic = false,         #CA APM for Oracle WebLogic Server
  $enable_WebLogicPortal = false,         #CA APM for Oracle WebLogic Portal
  $enable_WebSphere = false,         #CA APM for IBM WebSphere Application Server for Distributed Environments
  $enable_WebSpherePortal = false,         #CA APM for IBM WebSphere Portal
  $enable_WebSphereMQandMB = false,         #CA APM for IBM WebSphere MQ and IBM WebSphere Message Broker
  $enable_WebSphereZOS = false,         #CA APM for IBM WebSphere Application Server for z/OS
  $enable_IBMCTG = false,         #CA APM for IBM CICS Transaction Gateway 
  $enable_IBMzOSExtension = false,         #CA APM for IBM z/OS  
  $enable_Sysview = false,         #CA Cross-Enterprise Application Performance Management
  $enable_SiteMinder = false,         #CA APM for CA SiteMinder Web Access Manager 
  $enable_SiteMinderSNMP = false,         #CA APM for CA SiteMinder SNMP Collector  
  $enable_SOA = true, #SOA Monitoring Options
  $enable_OSB = false,         #CA APM for Oracle Service Bus
  $enable_TibcoBW = false,         #CA APM for TIBCO BusinessWorks
  $enable_TibcoEMS = false,         #CA APM for TIBCO Enterprise Message Service
  $enable_WPSandWESB = false,         #CA APM for IBM WebSphere Process Server/Business Process Management
  $enable_WMBroker = false,         #CA APM for webMethods Broker 
  $enable_WebMethodsIS = false,         #CA APM for webMethods Integration Server 
  $enable_CloudMonitor = false,         #CA APM Integration with Cloud Monitor
  $enable_CALISA = false,         #CA APM Integration for CA LISA
  
  # APM Database Settings
  $database = $caapm::params::apm_db,
  $db_host = $caapm::params::db_host,
  $db_port = $caapm::params::db_port,
  $db_name = $caapm::params::db_name,
  $db_user_name = $caapm::params::db_user_name,
  $db_user_passwd = $caapm::params::db_user_passwd,

  $pg_admin_user = $caapm::params::pg_admin_user,
  $pg_admin_passwd = $caapm::params::pg_admin_passwd,
  $pg_install_timeout = $caapm::params::pg_install_timeout,
  
  # Enterprise Manager As Windows Service Settings
  $config_as_service = true,
  $service_name = 'IScopeEM',
  $service_display_name = 'Introscope Enterprise Manager',

  # Enterprise Manager Advanced JVM Settings
  $emLaxNlCurrentVm = '',     # Specify the path to the JVM that will be used to run the Enterprise Manager. Leave blank for default
  $emLaxNlJavaOptionAdditional = '',  # Specify any desired command line arguments to be used by the Enterprise Manager JVM.
#  $emLaxNlJavaOptionAdditional = '-Xms512m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',

  # WebView Install Settings
  $webview_port = $caapm::params::webview_port,
  $webview_em_host = $caapm::params::em_host,
  $webview_em_port = $caapm::params::default_port,
  
  # WebView As Windows Service Settings
  $config_wv_as_service = true,
  $wv_service_name = 'IScopeWV',
  $wv_service_display_name = 'Introscope WebView',
  
  # WebView Advanced JVM Settings
  $wvLaxNlCurrentVm = '',     # Specify the path to the JVM that will be used to run the WebView. Leave blank for default
  $wvLaxNlJavaOptionAdditional = '',  # Specify any desired command line arguments to be used by the WebView JVM.
#  $wvLaxNlJavaOptionAdditional='-Xms128m -Xmx512m -Djava.awt.headless=true -Dorg.owasp.esapi.resources=./config/esapi'  

  # ProbeBuilder Advanced JVM Settings
  $pbLaxNlCurrentVm = '',     # Specify the path to the JVM that will be used to run the Workstation. Leave blank for default
  $pbLaxNlJavaOptionAdditional = '',  # Specify any desired command line arguments to be used by the ProbeBuilder JVM.
#  $pbLaxNlJavaOptionAdditional='-Xms32m -Xmx64m'  


) inherits caapm::params {
  
  include staging
  require caapm::osgi

#  $user_install_dir = to_windows_escaped("${install_dir}")
  $user_install_dir = "${install_dir}"
  
  case $database {
    'postgres': {
        $pg_dir = $caapm::params::pg_dir
        $pg_admin_user = $caapm::params::pg_admin_user
        $pg_admin_passwd = $caapm::params::pg_admin_passwd
    }
    'oracle' : {}
    default: {}   
  }
  
  $pkg_name = "CA APM Introscope ${version}" 
  $eula_file = 'ca-eula.txt'
  $resp_file = 'EnterpriseManager.ResponseFile.txt'
  $lic_file = "${ipaddress}.em.lic"
    
  $puppet_src = "puppet:///modules/${module_name}"

  $resp_src = "${puppet_src}/${resp_file}"

  # determine the executable package  
  $pkg_bin = $::operatingsystem ? {
    'windows' => "introscope${version}${operatingsystem}AMD64.exe",
    default  => "introscope${version}unix.bin",
  }
  
  # download the eula.txt  
  staging::file { $eula_file:
    source => "${puppet_src}/${version}/${eula_file}",
    subdir => $staging_subdir,
  }  
  
  # download the Enterprise Manager installer  
  staging::file { $pkg_bin:
    source => "${puppet_src}/${version}/${pkg_bin}",
    subdir => $staging_subdir,
    require => Staging::File[$eula_file],
    
  }
  
  # generate the response file
  file { $resp_file:
    path => "$::staging_windir/$staging_subdir/$resp_file",
    ensure => present,
    content => template("$module_name/$version/$resp_file"),
    source_permissions => ignore,
  }

  # install the Enterprise Manager package
  package { $pkg_name :
    ensure => "$version",
    source => "$::staging_windir\\$staging_subdir\\$pkg_bin",
    install_options => [" -f $::staging_windir\\$staging_subdir\\$resp_file" ],
    require => [File[$resp_file], Staging::File[$pkg_bin]]
  }
  
  # if features has Enterprise Manager
  if $features =~ /Enterprise Manager\./ {
    file { $lic_file:
      source => "${puppet_src}/license/${lic_file}",
      notify  => Service[$service_name],  
      path => "${install_dir}license/${lic_file}",
      require => Package[$pkg_name],
    }  
   
    # ensure the service is running
    service { $service_name:
      ensure  => $config_as_service,
      enable  => true,
      require => Package[$pkg_name],
    }
  }
  
  # if features has WebView
  if $features =~ /WebView\./ {
    service { $wv_service_name:
      ensure  => $config_wv_as_service,
      enable  => true,
      require => Package[$pkg_name],
    }  
  }
  
}
