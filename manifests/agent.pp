#
# == Define: caapm::database
#
# This installs the CA APM Database PostgreSQL Bundle
#
#

class caapm::agent (
  $version                 = $::caapm::version,
  $agents_dir              = $::caapm::agents_dir,

  $owner                   = $::caapm::owner,
  $group                   = $::caapm::group,
  $mode                    = $::caapm::mode,

  $execPath                = '/bin:/usr/sbin',

  $stage_dir               = '/tmp',  # this class will need to inherit from defaults for os specific settings

  # AutoProbe Properties
  $autoprobe_enable           = true, # true/false

  # Custom Log File Location
  $logs_dir                   = 'logs',

  # Directives Files
  $websphere_directivesFiles  = 'websphere-typical.pbl',
  $weblogic_directivesFile    = 'weblogic-typical.pbl',
  $default_directivesFile     = 'default-typical.pbl',
  $tomcat_directivesFiles     = 'tomcat-typical.pbl',

  # Logging Configuration
  $logConfig                  = 'INFO, logfile',

  $additivity_introscopeAgent                 = false,
  $appender_console                           = 'com.wily.org.apache.log4j.ConsoleAppender',
  $appender_console_layout                    = 'com.wily.org.apache.log4j.PatternLayout',
  $appender_console_layout_ConversionPattern  = '%d{M/dd/yy hh:mm:ss a z} [%-3p] [%c] %m%n',
  $appender_console_target                    = 'System.err',
  $appender_logfile                           = 'com.wily.introscope.agent.AutoNamingRollingFileAppender',
  $appender_logfile_layout                    = 'com.wily.org.apache.log4j.PatternLayout',
  $appender_logfile_layout_conversionPattern  = '%d{M/dd/yy hh:mm:ss a z} [%-3p] [%c] %m%n',
  $appender_logfile_maxBackupIndex            = '4',
  $appender_logfile_maxFileSize               = '2MB',

  # DNS lookup configuration
  $dns_lookup_type      = 'separateThread',
  $dns_lookup_max_wait  = '200',            # milliseconds

  # Enterprise Manager Connection Order
  $connectionOrder      = 'DEFAULT',

  # Additional properties for connecting to the Enterprise Manager using SSL
  $trustStore     = undef,
  $trustPassword  = undef,
  $keyStore       = undef,
  $keyPassword    = undef,
  $cipherSuites   = undef,

  # Enterprise Manager Failback Retry Interval
  $failbackRetryInterval  = '120',     # seconds

  # Custom Process Name
  $customProcessName  = 'WebSphere',

  # Default Process Name
  $defaultProcessName = 'WebSphere',

  # Agent Naming
  $agentNameSystemPropertyKey             = undef,
  $agentAutoNamingEnabled                 = false,
  $agentAutoNamingMaximumConnectionDelay  = '120',  # seconds
  $agentAutoRenamingInterval              = '10',   # minutes
  $disableLogFileAutoNaming               = false,
  $agentName                              = 'WebSphere Agent',
  $displayHostnameAsFqdn                  = false,

  # Agent Socket Rate Metrics
  $reportRateMetrics                = false,

  # Agent Memory Overhead Setting
  $reduceAgentMemoryOverhead        = false,

  # Agent I/O Socket Metrics
  $io_socket_client_hosts           = undef,
  $io_socket_client_ports           = undef,
  $io_socket_server_ports           = undef,

  # Agent NIO Metrics
  $nio_datagram_client_hosts        = undef,
  $nio_datagram_client_ports        = undef,
  $nio_datagram_server_ports        = undef,
  $nio_socket_client_hosts          = undef,
  $nio_socket_client_ports          = undef,
  $nio_socket_server_ports          = undef,

  # Agent Extensions Directory
  $agent_extensions_directory       = '../ext',
  $extensions_eagerLoader           = 'enabled',  # disabled/enabled/cached

  # Agent Common Directory
  $agent_common_directory           = '../../common',

  # Agent Thread Priority
  $agent_thread_all_priority        = '5',   # 1 (low) to 10 (high)

  # Cloned Agent Configuration
  $agent_clonedAgent                = false,

  # Platform Monitor Configuration
  $agent_platform_monitor_system    = undef,

  # WebSphere PMI Configuration
  $pmi_enable                       = true,
  $pmi_filter_objRef                = false,
  $pmi_enable_threadPoolModule      = true,
  $pmi_enable_servletSessionsModule = true,
  $pmi_enable_connectionPoolModule  = true,
  $pmi_enable_beanModule            = false,
  $pmi_enable_transactionModule     = false,
  $pmi_enable_webAppModule          = false,
  $pmi_enable_jvmRuntimeModule      = false,
  $pmi_enable_systemModule          = false,
  $pmi_enable_cacheModule           = false,
  $pmi_enable_orbPerfModule         = false,
  $pmi_enable_j2cModule             = true,
  $pmi_enable_webServicesModule     = false,
  $pmi_enable_wlmModule             = false,
  $pmi_enable_wsgwModule            = false,
  $pmi_enable_alarmManagerModule    = false,
  $pmi_enable_hamanagerModule       = false,
  $pmi_enable_objectPoolModule      = false,
  $pmi_enable_schedulerModule       = false,
  $pmi_enable_jvmpiModule           = false,
  $pmi_enable_SIB_Service           = false,

  # PMI properties for Websphere Process Server
  $pmi_enable_WBIStats_RootGroup   = true,
  $pmi_enable_SCAStats_RootGroup   = true,

  # JMX Configuration
  $jmx_enable                     = false,
  $jmx_maxpollingduration_enable  = false,
  $jmx_ratecounter_enable         = false,
  $jmx_ratecounter_reset_enable   = false,
  $jmx_compositedata_enable       = false,

  $jsr77_disable                  = true,
  $jmx_name_primarykeys_websphere = 'J2EEServer,Application,j2eeType,JDBCProvider,name,mbeanIdentifier',
  $jmx_name_primarykeys_weblogic  = 'Type,Name',
  $jmx_name_primarykeys_tomcat    = undef,

  $jmx_name_filter_websphere      = undef,
  $jmx_name_filter_weblogic       = 'ThreadPoolRuntime:ExecuteThreadIdleCount,ThreadPoolRuntime:ExecuteThreadTotalCount,ThreadPoolRuntime:HoggingThreadCount,ThreadPoolRuntime:PendingUserRequestCount,ThreadPoolRuntime:QueueLength,ThreadPoolRuntime:StandbyThreadCount,ThreadPoolRuntime:Throughput,JDBC*Runtime*:ActiveConnectionsCurrentCount,JDBC*Runtime*:ActiveConnectionsHighCount,JDBC*Runtime*:ConnectionDelayTime,JDBC*Runtime*:ConnectionsTotalCount,JDBC*Runtime*:CurrCapacity,JDBC*Runtime*:CurrCapacityHighCount,JDBC*Runtime*:FailedReserveRequestCount,JDBC*Runtime*:FailuresToReconnectCount,JDBC*Runtime*:HighestNumAvailable,JDBC*Runtime*:HighestNumUnavailable,JDBC*Runtime*:LeakedConnectionCount,JDBC*Runtime*:NumAvailable,JDBC*Runtime*:NumUnavailable,JDBC*Runtime*:WaitingForConnectionCurrentCount,JDBC*Runtime*:WaitingForConnectionFailureTotal,JDBC*Runtime*:WaitingForConnectionHighCount,JDBC*Runtime*:WaitingForConnectionSuccessTotal,JDBC*Runtime*:WaitingForConnectionTotal,JDBC*Runtime*:WaitSecondsHighCount,JMSDestinationRuntime*:BytesCurrentCount,JMSDestinationRuntime*:BytesHighCount,JMSDestinationRuntime*:BytesPendingCount,JMSDestinationRuntime*:BytesReceivedCount,JMSDestinationRuntime*:ConsumersCurrentCount,JMSDestinationRuntime*:ConsumersHighCount,JMSDestinationRuntime*:ConsumersTotalCount,JMSDestinationRuntime*:MessagesCurrentCount,JMSDestinationRuntime*:MessagesDeletedCurrentCount,JMSDestinationRuntime*:MessagesHighCount,JMSDestinationRuntime*:MessagesPendingCount,JMSDestinationRuntime*:MessagesReceivedCount,WorkManagerRuntime*:CompletedRequests,WorkManagerRuntime*:PendingRequests,WorkManagerRuntime*:StuckThreadCount,ExecuteQueueRuntime*:ExecuteThreadCurrentIdleCount,ExecuteQueueRuntime*:ExecuteThreadTotalCount,ExecuteQueueRuntime*:PendingRequestCurrentCount,ExecuteQueueRuntime*:ServicedRequestTotalCount,WebAppComponentRuntime*:OpenSessionsCurrentCount,WebAppComponentRuntime*:OpenSessionsHighCount,WebAppComponentRuntime*:SessionsOpenedTotalCount,WebAppComponentRuntime*:SessionTimeoutSecs,JDBC*Runtime*:PrepStmtCacheAccessCount,JDBC*Runtime*:PrepStmtCacheAddCount,JDBC*Runtime*:PrepStmtCacheCurrentSize,JDBC*Runtime*:PrepStmtCacheDeleteCount,JDBC*Runtime*:PrepStmtCacheHitCount,JDBC*Runtime*:PrepStmtCacheMissCount',
  $jmx_name_filter_tomcat         = undef,

  $jmx_ignore_attributes          = undef,
  $jmx_exclude_string_metrics     = true,

  # WLDF Configuration
  $wldf_enable                    = false,

  # LeakHunter Configuration
  $leakhunter_enable                          = false,
  $leakhunter_logfile_append                  = false,
  $leakhunter_leakSensitivity                 = '5',
  $leakhunter_timeout                         = '120',  # minutes
  $leakhunter_collectAllocationStackTraces    = false,

  $leakhunter_ignore_on_websphere = [
	  'org.apache.taglibs.standard.lang.jstl.*',
	  'net.sf.hibernate.collection.*',
	  'org.jnp.interfaces.FastNamingProperties',
	  'java.util.SubList',
	  'com.ibm.wps.state.accessors.collections.MapOnNode$EntrySet',
	  'com.ibm.ws.ejbpersistence.dataaccess.*',
	  'com.ibm.ws.rsadapter.cci.*',
	  'com.sun.faces.context.BaseContextMap$EntrySet',
	  'com.sun.faces.context.BaseContextMap$KeySet',
	  'com.sun.faces.context.SessionMap',
	  'java.util.Collections$UnmodifiableMap',
	  'org.hibernate.collection.PersistentSet'
	  ],

  # chuahm - weblogic not validated
  $leakhunter_ignore_on_weblogic   = [
    'org.apache.taglibs.standard.lang.jstl.*',
    'com.bea.medrec.entities.RecordEJB_xwcp6o__WebLogic_CMP_RDBMS',
		'net.sf.hibernate.collection.*',
		'org.jnp.interfaces.FastNamingProperties',
		'java.util.SubList',
		'com.sun.faces.context.BaseContextMap$EntrySet',
		'com.sun.faces.context.BaseContextMap$KeySet',
		'com.sun.faces.context.SessionMap',
		'java.util.Collections$UnmodifiableMap',
		'org.hibernate.collection.PersistentSet'
	  ],

	# chuahm - default not validated
  $leakhunter_ignore_on_default  = [
		'org.apache.taglibs.standard.lang.jstl.*',
		'com.bea.medrec.entities.RecordEJB_xwcp6o__WebLogic_CMP_RDBMS',
		'net.sf.hibernate.collection.*',
		'org.jnp.interfaces.FastNamingProperties',
		'java.util.SubList',
		'com.sun.faces.context.BaseContextMap$EntrySet',
		'com.sun.faces.context.BaseContextMap$KeySet',
		'com.sun.faces.context.SessionMap',
		'java.util.Collections$UnmodifiableMap',
		'org.hibernate.collection.PersistentSet'
	],

	$leakhunter_ignore_on_tomcat   = [
	  'org.apache.taglibs.standard.lang.jstl.*',
		'net.sf.hibernate.collection.*',
		'org.jnp.interfaces.FastNamingProperties',
		'java.util.SubList',
		'com.sun.faces.context.BaseContextMap$EntrySet',
		'com.sun.faces.context.BaseContextMap$KeySet',
		'com.sun.faces.context.SessionMap',
		'java.util.Collections$UnmodifiableMap',
		'org.hibernate.collection.PersistentSet'
	],

  # SQL Agent Configuration
  $sqlagent_turnoffmetrics = false,
  $sqlagent_artonly        = false,
  $sqlagent_turnofftrace   = false,
  $sqlagent_rawsql         = false,

  # SQL Agent Normalizer extension
  $sqlagent_normalizer_extension   = undef, # use RegexSqlNormalizer if being enabled

  # RegexSqlNormalizer extension
  $sqlagent_normalizer_regex_matchFallThrough    = false,
  $sqlagent_normalizer_regex_keys  = 'key1',
  $sqlagent_normalizer_regex_key1_pattern        = "(\".*?\")|(\'.*?\')|(\\b[0-9,.]+\\b)|((?i)\\bTRUE\\b|\\bFALSE\\b)",
  $sqlagent_normalizer_regex_key1_replaceAll     = true,
  $sqlagent_normalizer_regex_key1_replaceFormat  = '?',
  $sqlagent_normalizer_regex_key1_caseSensitive  = false,

  # Cross JVM Tracing
  $crossjvm_enable         = true,

  # chuahm - whats this for???
  # SOA Performance Management Agent Settings
  $agent_httpheaderinsertion_enabled             = true,
  $agent_httpheaderread_enabled                  = true,
  $agent_soapheaderinsertion_enabled             = true,
  $agent_soapheaderread_enabled                  = true,

  $agent_metricClamp                             = '50000',

  $transactiontracer_userid_method  = 'HttpServletRequest.getRemoteUser',
  $transactiontracer_userid_key     = '<application defined key string>',

  $tt_httprequest_headers           = 'User-Agent',
  $tt_httprequest_parameters        = 'parameter1,parameter2',
  $tt_httpsession_attributes        = 'attribute1,attribute2',
  $tt_capture_sessionid             = true,
  $tt_component_count_clamp         = '5000',
  $tt_head_filter_clamp             = '30',

  # Cross Process Transaction Trace
  $crossprocess_compression             = 'lzma',
  $crossprocess_compression_minlimit    = '1500',
  $crossprocess_correlationid_maxlimit  = '4096',

  # TT Sampling
  $tt_sampling_enabled              = true,
  $tt_clamp                         = '50',
  $tt_tail_filter_propagate_enable  = true,
  $tt_perinterval_count    = '1',
  $tt_interval_seconds     = '120',

  # URL Grouping Configuration
  $urlgroup_keys                = 'default',
  $urlgroup_default_pathprefix  = '*',          # chuahm - commented out in template
  $urlgroup_default_format      = 'Default',    # chuahm - commented out in template

  # Synthetic Transaction Configuration
  $synthetic_tt_enable     = false,             # chuahm - not found in template
  $synthetic_header_names  = 'Synthetic_Transaction,x-wtg-info,lisaframeid',
  $synthetic_user_name     = 'Synthetic_Trace_By_Vuser',
  $synthetic_node_name     = 'Synthetic Users',
  $non_synthetic_node_name = 'Real Users',

  # Error Detector Configuration
  $errorsnapshots_enable    = true,
  $errorsnapshots_throttle  = '10',
  $errorsnapshots_ignore    = [
									              '*com.company.HarmlessException*',
														    '*HTTP Error Code: 404*',
														    ],

  $stalls_thresholdseconds  = '30',
  $stalls_resolutionseconds = '10',

  # TT Sampling
  $transactiontracer_sampling_perinterval = '1',   # count
  $transactiontracer_sampling_interval    = '120',   # seconds

  # Remote Configuration Settings
  $remoteagent_configuration_enabled             = true,
  $remoteagent_configuration_allowed_files       = 'domainconfig.xml',

  # Bootstrap Classes Instrumentation Manager
  $bootstrap_classes_manager_enabled             = true,
  $bootstrap_classes_manager_wait_at_startup     = 240,

  # Remote Dynamic Instrumentation Settings
  $remoteagent_dynamic_instrumentation_enabled   = true,

  # Dynamic Instrumentation Settings
  $autoprobe_dynamicinstrument_enabled                = true,
  $autoprobe_dynamicinstrument_pollInterval           = '1',    # minutes
  $autoprobe_dynamicinstrument_classFileSizeLimit     = '1',    # MB
  $autoprobe_dynamic_limitRedefinedClassesPerBatchTo  = '10',

  # Deep Inheritance Settings
  $autoprobe_deepinheritance_enabled             = true,
  $autoprobe_deepinheritance_auto_turnoff_enable = true,
  $autoprobe_deepinheritance_auto_turnoff_requests_per_interval = 100,
  $autoprobe_deepinheritance_auto_turnoff_maxtime_per_interval  = 12000,
  $autoprobe_deepinheritance_auto_turnoff_maxtime_total         = 120000,

  # Multiple Inheritance Settings
  $autoprobe_hierarchysupport_enabled                 = true,   # chuahm - commented out in template
  $autoprobe_hierarchysupport_runOnceOnly             = false,  # chuahm - commented out in template
  $autoprobe_hierarchysupport_pollInterval            = '5',    # minutes # chuahm - commented out in template
  $autoprobe_hierarchysupport_execution               = '3',    # count # chuahm - commented out in template
  $autoprobe_hierarchysupport_disableLogging          = true,   # chuahm - commented out in template
  $autoprobe_hierarchysupport_disableDirectivesChange = true,   # chuahm - commented out in template

  # Metric Aging
  $metricAging_enable                 = true,
  $metricAging_heartbeatInterval      = '86400',
  $metricAging_dataChunk              = '500',
  $metricAging_numberTimeslices       = '180000',

  $metricAging_exclude_for_websphere  = ['Threads*', 'ChangeDetector.AgentID'],

  $metricAging_exclude_for_weblogic   = ['Threads*', 'ChangeDetector.AgentID'],    # chuahm - not validated

  $metricAging_exclude_for_default    = ['Threads*', 'ChangeDetector.AgentID'],    # chuahm - not validated

  # Servlet Header Decorator
  $decorator_enabled       = false,
  $decorator_security      = 'encrypted',

  # ChangeDetector configuration
  $changeDetector_enable                    = false,
  $changeDetector_rootDir                   = './changedetector',
  $changeDetector_isengardStartupWaitTime   = '15',                 # seconds
  $changeDetector_waitTimeBetweenReconnect  = '10',               # seconds
  $changeDetector_agentId                   = undef,
  $changeDetector_profile                   = './common/ChangeDetector-config.xml',
  $changeDetector_profileDir                = 'changeDetector_profiles',

  # Data Compression
  $changeDetector_compressEntries_enable    = true,
  $changeDetector_compressEntries_batchSize = '1000',

  # Application Map Agent Side
  $appmap_enabled                     = true,
  $appmap_metrics_enabled             = true,
  $appmap_catalystIntegration_enabled = false,
  $appmap_queue_size                  = 1000,
  $appmap_queue_period                = 1000,
  $appmap_intermediateNodes_enabled   = false,
  $appmap_levels_enabled              = 'MethodClass',
  $appmap_owners_enabled              = 'Application,BusinessTransactionComponent',

  # Application Map and Socket
  $appmap_sockets_managed_reportToAppmap         = true,
  $appmap_sockets_managed_reportClassAppEdge     = false,
  $appmap_sockets_managed_reportMethodAppEdge    = true,
  $appmap_sockets_managed_reportClassBtEdge      = false,
  $appmap_sockets_managed_reportMethodBTEdge     = true,

  # Business Recording
  $bizRecording_enabled       = true,
  $bizdef_matchPost           = 'before',           # never/after/before
  $bizdef_matchPost_vetoedUri = undef,

  # Powerpack for SiteMinder Web Access Manager
  $siteMinder_webAgent_traceThreshold = '5000',

  # SOA Extension For Tibco BW Properties
  $metricAging_metricExclude_ignore_Xplus1                = undef,
  $soaextension_tibcobw_hawkmonitor_enabled               = false,
  $soaextension_tibcobw_hawkmointor_frequency             = '30000',
  $soaextension_tibcobw_jobmonitor_enabled                = false,
  $soaextension_tibcobw_jobmointor_frequency              = '30000',
  $soaextension_tibcobw_mbbs_enabled                      = true,
  $soaextension_tibcobw_correlationserialization_enabled  = true,

  # Garbage collection and Memory Monitoring
  $gcMonitor_enable = true,

  # Thread Dump Collection
  $threadDump_enable                  = true,
  $threadDump_maxStackElements        = '25000',
  $threadDump_deadLockpoller_enable   = true,
  $threadDump_deadLockPollerInterval  = '15000',

  # Primary network interface selector
  $primary_net_interface_name = 'eth0.0',

  # Default Backend Legacy
  $configuration_defaultBackends_legacy = false,

  #  Transaction Structure aging properties
  $harvesting_transaction_creation_checkperiod              = '30000',
  $harvesting_transaction_aging_checkperiod                 = '30000',
  $harvesting_transaction_aging_period                      = '60000',
  $harvesting_transaction_aging_attentionLevel              = '5',      # percent
  $harvesting_transaction_attentionlevel_absolute           = '100000',
  $harvesting_transaction_creation_attentionLevel_absolute  = '100000',
  $harvesting_transaction_aging_duration_max                = '30000',

  #  Transaction Structure properties
  $blame_transaction_doTransactionTrace = true,
  $blame_highConcurrency_enabled        = false,
  $blame_highConcurrency_stripes        = '16',
  $blame_useSharedAccumulators_enabled  = true,
  $blame_stall_trace_enabled            = true,
  $blame_synchronized_enabled           = true,

  # Sustainability metrics
  $blame_transactions_debugMetrics_enabled  = false,
  $harvesting_debugMetrics_enabled          = false,
  $concurrentMapPolicy_generateMetrics      = false,

  # Socket Clamp level property
  $agent_sockets_clamp_level  = '100',

  # Smart Instrumentation properties
  $deep_instrumentation_enabled               = true,
  $deep_trace_enabled                         = true,
  $deep_instrumentation_level                 = 'low',
  $deep_instrumentation_level_batch_size      = 5,
  $deep_instrumentation_level_batch_interval  = 2,
  $deep_errorSnapshot_enable                  = true,
  $deep_stallSnapshot_enabled                 = true,
  $deep_instrumentation_max_methods           = '10000',
  $deep_trace_max_components                  = '1000',
  $deep_trace_max_consecutive_components      = '15',
  $deep_instrumentation_custom_prefixes       = 'java',
  $deep_automatic_trace_enabled               = true,
  $deep_automatic_trace_clamp                 = '10',
  $deep_entryPoint_enabled                    = true,
  $deep_entryPoint_skip_pkgs                  = undef,
  $deep_entryPoint_count_max                  = '100',

  # SOA property for 2.2.6 or later versions of JAXWS Jar
  $soa_JAXWSHeadersClassName                  = 'com.sun.xml.ws.transport.Headers',

  # External Business Transaction Monitoring properties
  $external_biz_enable          = true,
  $external_biz_header_size_max = '10',
  $external_biz_bt_count_max    = '100',

  # BRTM Business Transaction Monitoring properties
  $brtm_enabled                     = false,
  $brtm_snippetInsertionEnabled     = true,
  $brtm_excludeUrlList              = undef,
  $brtm_jsFunctionMetricsEnabled    = false,
  $brtm_geolocation_enabled         = false,

  # chuahm - not validated
  $collector_groups = undef,
  $connection_order = 'DEFAULT',
  $assigned_collector_group = 'group2',
  $notify_enabled  = false,

  ################################################################
  # EPAgent Specific
  ################################################################

  # Logging Configuration
  $logConfig_EPAgent    = 'INFO, logfile',

  $additivity_EPAgent   = false,

  # EPAgent Configuration
  $epagent_config_networkDataPort                         = '8000',
  $epagent_config_httpServerPort                          = '8080',
  $epagent_config_stalledStatelessPluginTimeoutInSeconds  = '60',

  # Plugin Configuration
  $epagent_stateful_myplugin_class                        = 'my.package.path.Class arg1 arg2 arg3',

  $epagent_metricscasesensitive = true,   # true/false/default

  # Agent Properties
  $epagent_customProcessName    = 'EPAgentProcess',
  $epagent_defaultProcessName   = 'UnknownProcess',
  $epagent_agentName            = 'EPAgent',

  # Agent Extensions Directory
  $epagent_extensions_directory = 'ext',

  # Stateful Plugins
  $stateful_plugin_names        = undef,
  $stateful_plugins             = undef,

  # Stateless Plugins
  $stateless_plugin_names       = undef,
  $stateless_plugins            = undef,

  $epagent_remoteagentconfiguration_enabled = false,

  # Agent Metric Aging
  $epagent_metricAging_turnOn             = true,
  $epagent_metricAging_heartbeatInterval  = '86400',
  $epagent_metricAging_dataChunk          = '500',
  $epagent_metricAging_numberTimeslices   = '180000',
  $metricAging_exclude_for_epagent        = ['Threads*'],

  # ChangeDetector configuration properties
  $epagent_changeDetector_enable                        = false,
  $epagent_changeDetector_rootDir                       = undef,
  $epagent_changeDetector_isengardStartupWaitTimeInSec  = '15',
  $epagent_changeDetector_waitTimeBetweenReconnectInSec = '10',
  $epagent_changeDetector_enableEPA                     = true,
  $epagent_changeDetector_agentID                       = 'SampleApplicationName',
  $epagent_changeDetector_profile                       = 'ChangeDetector-config.xml',
  $epagent_changeDetector_profileDir                    = 'changeDetector_profiles',


  $puppet_src = "puppet:///modules/${module_name}",

)
inherits caapm
{

  $agent_pkg = "IntroscopeAgentANZ${version}.tar.gz"


  if $notify_enabled {
    notify {"Running agent with agents_dir = $agents_dir":}
    notify {"Running agent with logs_dir = $logs_dir":}
    notify {"Running agent with stage_dir = $stage_dir":}
  }

  include caapm::agent::install
  include caapm::agent::config
  include caapm::agent::profile
  include caapm::agent::service

  Class['caapm::agent::install'] ->
  Class['caapm::agent::config']  ->
  Class['caapm::agent::profile']  ->
  Class['caapm::agent::service']

  anchor {
    'caapm::agent::begin':
       before  => Class['caapm::agent::install','caapm::agent::config','caapm::agent::profile'],
       notify  => Class['caapm::agent::service'];
    'caapm::agent::end':
       require => Class['caapm::agent::service'];
  }

}
