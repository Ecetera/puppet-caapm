#
# == Define: caapm::em
#
# This installs the Enterprise Manager and its accompanying End User License Agreement file, eula.txt.
#
# Parameters:
# - $version the osgi version to download and install.
# - $souce_path the source location to obtain the files from.
#

define caapm::em (
  $version = '9.1.4.0',
  $user_install_dir = undef,
  $features = 'Enterprise Manager,WebView',

  # Enterprise Manager Upgrade toggle
  $upgradeEM = false,
  $upgraded_install_dir = undef,
  $upgrade_schema = false,

  # Enteprise Manager Ports Settings
  $default_port = 5001,
  $ssl_port = 5443,
  $web_port = 8081,

  # Enterprise Manager User Password Settings
  $admin_passwd = undef,
  $guest_passwd = undef,

  # Enterprise Manager Clustering Settings
  $clusterEM = false,        # Set to true if this Enterprise Manager will participate in a cluster.
  $cluster_role = undef,        # Specify clustering role for this EM. Valid values are "Collector", "Manager" or "CDV"

  # Enterprise Manager Transaction Storage Settings
  $txnTraceDataShelfLife = 14,
  $txnTraceDir = 'trace',
  $txnTraceDiskSpaceCap = undef,

  # Enterprise Manager SmartStor Settings
  $smartstor_dir = 'data',

  # Enterprise Manager Thread Dump Settings
  $threaddump_dir = 'threaddump',

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
  $database = 'postgres',
  $db_host = 'localhost',
  $db_port = 5432,
  $db_name = 'cemdb',
  $db_user_name = 'admin',
  $db_user_passwd = 'wily',

  $postgres_dir = 'database',
  $pg_admin_user ='postgres',
  $pg_admin_passwd ='C@wilyapm90',
  $pg_install_timeout = 240000,
  $pg_as_service = true,

  # Enterprise Manager As Windows Service Settings
  $config_em_as_service = false,
  $em_service_name = 'IScopeEM',
  $em_service_display_name = 'Introscope Enterprise Manager',
  $start_em_as_service = true,

  # Enterprise Manager Advanced JVM Settings
  $emLaxNlCurrentVm = '',     # Specify the path to the JVM that will be used to run the Enterprise Manager. Leave blank for default
  $emLaxNlJavaOptionAdditional = '',  # Specify any desired command line arguments to be used by the Enterprise Manager JVM.
#  $emLaxNlJavaOptionAdditional = '-Xms512m -Xmx1024m -XX:MaxPermSize=256m -Dorg.owasp.esapi.resources=./config/esapi',

  # WebView Install Settings
  $webview_port = 8080,
  $webview_em_host = 'localhost',
  $webview_em_port = 5001,

  # WebView As Windows Service Settings
  $config_wv_as_service = false,
  $wv_service_name = 'IScopeWV',
  $wv_service_display_name = 'Introscope WebView',
  $start_wv_as_service = true,

  # WebView Advanced JVM Settings
  $wvLaxNlCurrentVm = '',     # Specify the path to the JVM that will be used to run the WebView. Leave blank for default
  $wvLaxNlJavaOptionAdditional = '',  # Specify any desired command line arguments to be used by the WebView JVM.
#  $wvLaxNlJavaOptionAdditional='-Xms128m -Xmx512m -Djava.awt.headless=true -Dorg.owasp.esapi.resources=./config/esapi'

  # ProbeBuilder Advanced JVM Settings
  $pbLaxNlCurrentVm = '',     # Specify the path to the JVM that will be used to run the Workstation. Leave blank for default
  $pbLaxNlJavaOptionAdditional = '',  # Specify any desired command line arguments to be used by the ProbeBuilder JVM.
#  $pbLaxNlJavaOptionAdditional='-Xms32m -Xmx64m'

  $owner  = 'Administrator',
  $group  = 'Users',
  $mode   = '0755',

  $puppet_src = "puppet:///modules/${module_name}"

){

  require staging

  $staging_subdir = $module_name
  $staging_path = $staging::params::path

  validate_absolute_path($user_install_dir)

  $user_install_dir_em = $::operatingsystem ? {
    'windows' => to_windows_escaped($user_install_dir),
    default  => $user_install_dir,
  }

  $target_dir = $upgradeEM ? {
    false => $user_install_dir_em,
    true => $::operatingsystem ? {
      'windows' => to_windows_escaped($upgraded_install_dir),
      default  => $upgraded_install_dir,
    },
    default => $user_install_dir_em
  }

  validate_absolute_path($target_dir)


  $osgi_eula_file = 'eula.txt'
  $osgi_pkg_name  = $::operatingsystem ? {
    'windows' => "osgiPackages.v${version}.windows.zip",
    default   => "osgiPackages.v${version}.unix.tar",
  }

  caapm::osgi { $version:
    eula_file => $osgi_eula_file,
    pkg_name  => $osgi_pkg_name
  }


  $pkg_name = "CA APM Introscope ${version}"
  $eula_file = 'ca-eula.txt'
  $resp_file = 'EnterpriseManager.ResponseFile.txt'
  $lic_file = "${::ipaddress}.em.lic"
  $failed_log = 'silent.install.failed.txt'

  $resp_src = "${puppet_src}/${resp_file}"

  # determine the executable package
  $pkg_bin = $::operatingsystem ? {
    'windows' => "introscope${version}${::operatingsystem}AMD64.exe",
    default   => "introscope${version}linuxAMD64.bin",
  }

  # download the eula.txt
  file { $eula_file:
    ensure => present,
    force  => true,
    path   => "${staging_path}/${staging_subdir}/${eula_file}",
    source => "${puppet_src}/${version}/${eula_file}",
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  # download the Enterprise Manager installer
  staging::file { $pkg_bin:
    source => "${puppet_src}/${version}/${pkg_bin}",
    subdir => $staging_subdir,
  }

  # generate the response file
  file { $resp_file:
    ensure  => present,
    force   => true,
    path    => "${staging_path}/${staging_subdir}/${resp_file}",
    content => template("${module_name}/${version}/${resp_file}"),
    owner   =>  $owner,
    group   =>  $group,
    mode    =>  $mode,
  }

  $install_options = $::operatingsystem ? {
    'windows' => "${staging_path}\\${staging_subdir}\\${resp_file}",
    default   => "${staging_path}/${staging_subdir}/${resp_file}",
  }

  file { $failed_log :
    ensure => absent,
    path   => "${staging_path}/${staging_subdir}/${failed_log}",
  }

  $em_as_service = ('Enterprise Manager' in $features) or $config_em_as_service
  $wv_as_service = ('WebView' in $features) or $config_wv_as_service

  case $::operatingsystem {
    CentOS, RedHat, OracleLinux, Ubuntu, Debian, SLES, Solaris: {
      exec { $pkg_name :
#        command     => "$staging_path/$staging_subdir/$pkg_bin -f $install_options;cat $staging_path/$staging_subdir/silent.install.failed.txt;true",
        command   => "${staging_path}/${staging_subdir}/${pkg_bin} -f ${install_options}",
        creates   =>  "${target_dir}launcher.jar",
        require   => [Caapm::Osgi[$version],File[$resp_file], Staging::File[$pkg_bin], File[$failed_log]],
        logoutput => true,
        returns   => [0,1],
        timeout   => 0,
        user      => "${owner}",
        before    => File[$lic_file],
        notify    => [Service[$em_service_name]],
      }

      # generate the SystemV init script
      file { $em_service_name:
        ensure  => present,
        force   => true,
        path    => "/etc/init.d/${em_service_name}",
        content => template("${module_name}/init.d/introscope"),
        owner   =>  $caapm::params::owner,
        group   =>  $caapm::params::group,
        mode    =>  '0755',
        notify  => Service[$em_service_name],
      }

      if $wv_as_service == true {
        # generate the SystemV init script
        file { $wv_service_name:
          ensure  => present,
          force   => true,
          path    => "/etc/init.d/${wv_service_name}",
          content => template("${module_name}/init.d/webview"),
          owner   =>  $caapm::params::owner,
          group   =>  $caapm::params::group,
          mode    =>  '0755',
          require => [File['WVCtrl.sh'],Exec[$pkg_name]],
          notify  => Service[$wv_service_name]
        }
      }

      # generate the WebView Control script
      file { 'WVCtrl.sh':
        ensure  => present,
        force   => true,
        path    => "${target_dir}/bin/WVCtrl.sh",
        source  => "${puppet_src}/bin/WVCtrl.sh",
        owner   => $owner,
        group   => $group,
        mode    => '0755',
        require => Exec[$pkg_name] ,
      }
    }

    windows: {
      # install the Enterprise Manager package
      package { $pkg_name :
        ensure          => $version,
        source          => "${staging_path}/${staging_subdir}/${pkg_bin}",
        install_options => [" -f ${install_options}" ],
        require         => [Caapm::Osgi[$version], File[$resp_file], Staging::File[$pkg_bin], File[$failed_log]],
        notify          => [Service[$em_service_name], Service[$wv_service_name]],
        allow_virtual   => true,
        before          => File[$lic_file],
      }
    }

    default: {}
  }

  file { $lic_file:
    ensure =>  present,
    source => "${puppet_src}/license/${lic_file}",
    path   => "${target_dir}license/${lic_file}",
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  # ensure the service is running
  service { $em_service_name:
    ensure  => $start_em_as_service,
    enable  => $em_as_service,
    require => File[$lic_file],
  }

  if $wv_as_service == true {
    service { $wv_service_name:
      ensure => $start_wv_as_service,
      enable => $wv_as_service,
    }
  }
}
