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

  $stage_dir               = '/tmp',  # this class will need to inherit from defaults for os specific settings

  $autoprobe_enable           = 'SomethingSerious',

  $logs_dir                   = 'logs',
  $logConfig                  = 'INFO, logfile',

  $websphere_directivesFiles  = 'websphere-typical.pbl',
  $weblogic_directivesFile    = 'weblogic-typical.pbl',

  $dnsLookupType              = 'separateThread',
  $dnsLookupMaxWait           = '200',
  $connectionOrder            = 'DEFAULT',

  $truststore              = undef,
  $trustpassword           = undef,
  $keystore                = undef,
  $keypassword             = undef,
  $ciphersuites            = undef,
  # Agent Naming
  $agentNameSystemPropertyKey = undef,
  $agentAutoNamingEnabled = false,
  $disableLogFileAutoNaming = false,

  # Enterprise Manager Failback Retry Interval
  $failback_retry_interval = 120,

  # Agent Socket Rate Metrics
  $report_rate_metrics     = false,

  # Agent Memory Overhead Setting
  $reduce_agent_memory_overhead    = false,

  # Agent I/O Socket Metrics
  $io_socket_client_hosts  = undef,
  $io_socket_client_ports  = undef,
  $io_socket_server_ports  = undef,

  # Agent NIO Metrics
  $nio_datagram_client_hosts       = undef,
  $nio_datagram_client_ports       = undef,
  $nio_datagram_server_ports       = undef,
  $nio_socket_client_hosts = undef,
  $nio_socket_client_ports = undef,
  $nio_socket_server_ports = undef,

  $eager_loader            = 'enabled',  # Possible values are: disabled, enabled, cached.

  # WebSphere PMI Configuration
  $pmi_enable              = true,
  $pmi_filter_object       = false,
  $pmi_enable_threadPoolModule     = true,
  $pmi_enable_servletSessionsModule              = true,
  $pmi_enable_connectionPoolModule = true,
  $pmi_enable_beanModule   = false,
  $pmi_enable_transactionModule    = false,
  $pmi_enable_webAppModule = false,
  $pmi_enable_jvmRuntimeModule     = false,
  $pmi_enable_systemModule = false,
  $pmi_enable_cacheModule  = false,
  $pmi_enable_orbPerfModule        = false,
  $pmi_enable_j2cModule    = true,
  $pmi_enable_webServicesModule    = false,
  $pmi_enable_wlmModule    = false,
  $pmi_enable_wsgwModule   = false,
  $pmi_enable_alarmManagerModule   = false,
  $pmi_enable_hamanagerModule      = false,
  $pmi_enable_objectPoolModule     = false,
  $pmi_enable_schedulerModule      = false,
  $pmi_enable_jvmpiModule  = false,
  $pmi_enable_SIB_Service  = false,

  # PMI properties for Websphere Process Server
  $pmi_enable_WBIStats_RootGroup   = true,
  $pmi_enable_SCAStats_RootGroup   = true,

  # JMX Configuration
  $jmx_enable              = false,
  $jmx_maxpollingduration_enable   = false,
  $jmx_ratecounter_enable  = false,
  $jmx_ratecounter_reset_enable    = false,
  $jmx_compositedata_enable        = false,

  $jsr77_disable           = true,
  $jmx_name_primarykeys_websphere  = 'J2EEServer,Application,j2eeType,JDBCProvider,name,mbeanIdentifier',
  $jmx_name_primarykeys_weblogic   = 'Type,Name',

  $jmx_name_filter_websphere       = undef,
  $jmx_name_filter_weblogic        = 'ThreadPoolRuntime:ExecuteThreadIdleCount,ThreadPoolRuntime:ExecuteThreadTotalCount,ThreadPoolRuntime:HoggingThreadCount,ThreadPoolRuntime:PendingUserRequestCount,ThreadPoolRuntime:QueueLength,ThreadPoolRuntime:StandbyThreadCount,ThreadPoolRuntime:Throughput,JDBC*Runtime*:ActiveConnectionsCurrentCount,JDBC*Runtime*:ActiveConnectionsHighCount,JDBC*Runtime*:ConnectionDelayTime,JDBC*Runtime*:ConnectionsTotalCount,JDBC*Runtime*:CurrCapacity,JDBC*Runtime*:CurrCapacityHighCount,JDBC*Runtime*:FailedReserveRequestCount,JDBC*Runtime*:FailuresToReconnectCount,JDBC*Runtime*:HighestNumAvailable,JDBC*Runtime*:HighestNumUnavailable,JDBC*Runtime*:LeakedConnectionCount,JDBC*Runtime*:NumAvailable,JDBC*Runtime*:NumUnavailable,JDBC*Runtime*:WaitingForConnectionCurrentCount,JDBC*Runtime*:WaitingForConnectionFailureTotal,JDBC*Runtime*:WaitingForConnectionHighCount,JDBC*Runtime*:WaitingForConnectionSuccessTotal,JDBC*Runtime*:WaitingForConnectionTotal,JDBC*Runtime*:WaitSecondsHighCount,JMSDestinationRuntime*:BytesCurrentCount,JMSDestinationRuntime*:BytesHighCount,JMSDestinationRuntime*:BytesPendingCount,JMSDestinationRuntime*:BytesReceivedCount,JMSDestinationRuntime*:ConsumersCurrentCount,JMSDestinationRuntime*:ConsumersHighCount,JMSDestinationRuntime*:ConsumersTotalCount,JMSDestinationRuntime*:MessagesCurrentCount,JMSDestinationRuntime*:MessagesDeletedCurrentCount,JMSDestinationRuntime*:MessagesHighCount,JMSDestinationRuntime*:MessagesPendingCount,JMSDestinationRuntime*:MessagesReceivedCount,WorkManagerRuntime*:CompletedRequests,WorkManagerRuntime*:PendingRequests,WorkManagerRuntime*:StuckThreadCount,ExecuteQueueRuntime*:ExecuteThreadCurrentIdleCount,ExecuteQueueRuntime*:ExecuteThreadTotalCount,ExecuteQueueRuntime*:PendingRequestCurrentCount,ExecuteQueueRuntime*:ServicedRequestTotalCount,WebAppComponentRuntime*:OpenSessionsCurrentCount,WebAppComponentRuntime*:OpenSessionsHighCount,WebAppComponentRuntime*:SessionsOpenedTotalCount,WebAppComponentRuntime*:SessionTimeoutSecs,JDBC*Runtime*:PrepStmtCacheAccessCount,JDBC*Runtime*:PrepStmtCacheAddCount,JDBC*Runtime*:PrepStmtCacheCurrentSize,JDBC*Runtime*:PrepStmtCacheDeleteCount,JDBC*Runtime*:PrepStmtCacheHitCount,JDBC*Runtime*:PrepStmtCacheMissCount',

  $jmx_ignore_attributes   = undef,
  $jmx_exclude_string_metrics      = true,

  # LeakHunter Configuration
  $leakhunter_enable       = false,
  $leakhunter_sensitivity  = 5,
  $leakhunter_timeout_minutes      = 120,
  $leakhunter_collect_allocation_stack_traces    = false,

  $leakhunter_ignore_on_websphere  = [
    "org.apache.taglibs.standard.lang.jstl.*",
    "net.sf.hibernate.collection.*",
    "org.jnp.interfaces.FastNamingProperties",
    "com.ibm.wps.state.accessors.collections.MapOnNode\$EntrySet",
    "com.ibm.ws.ejbpersistence.dataaccess.*",
    "com.ibm.ws.rsadapter.cci.*",
    "com.sun.faces.context.BaseContextMap\$EntrySet",
    "com.sun.faces.context.BaseContextMap\$KeySet",
    "com.sun.faces.context.SessionMap",
    "java.util.Collections\$UnmodifiableMap",
    "org.hibernate.collection.PersistentSet",
    ],

  $leakhunter_ignore_on_weblogic   = [
    "org.apache.taglibs.standard.lang.jstl.*",
    "com.bea.medrec.entities.RecordEJB_xwcp6o__WebLogic_CMP_RDBMS",
    "net.sf.hibernate.collection.*",
    "org.jnp.interfaces.FastNamingProperties",
    "java.util.SubList",
    "com.sun.faces.context.BaseContextMap\$EntrySet",
    "com.sun.faces.context.BaseContextMap\$KeySet",
    "com.sun.faces.context.SessionMap",
    "java.util.Collections\$UnmodifiableMap",
    "org.hibernate.collection.PersistentSet",
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

  # SOA Performance Management Agent Settings
  $agent_httpheaderinsertion_enabled             = true,
  $agent_httpheaderread_enabled    = true,
  $agent_soapheaderinsertion_enabled             = true,
  $agent_soapheaderread_enabled    = true,

  $agent_metric_clamp      = 50000,

  $tt_userid_method        = "HttpServletRequest.getRemoteUser",
  $tt_userid_key           = '\<application defined key string\>',
  $tt_httprequest_headers  = "User-Agent",
  $tt_httprequest_parameters       = "parameter1,parameter2",
  $tt_httpsession_attributes       = "attribute1,attribute2",
  $tt_capture_sessionid    = true,
  $tt_component_count_clamp        = 5000,
  $tt_head_filter_clamp    = 30,

  # Cross Process Transaction Trace
  $crossprocess_compression        = 'lzma',
  $crossprocess_compression_minlimit             = 1500,
  $crossprocess_correlationid_maxlimit           = 4096,

  $tt_tail_filter_propagate_enable = true,

  # URL Grouping Configuration
  $urlgroup_keys           = [{
    }
    ],

  # Synthetic Transaction Configuration
  $synthetic_tt_enable     = false,
  $synthetic_header_names  = "Synthetic_Transaction,x-wtg-info,lisaframeid",
  $synthetic_user_name     = "Synthetic_Trace_By_Vuser",
  $synthetic_node_name     = "Synthetic Users",
  $non_synthetic_node_name = "Real Users",

  # Error Detector Configuration
  $errorsnapshots_enable   = true,
  $errorsnapshots_throttle = 10,
  $errorsnapshots_ignore   = ["*com.company.HarmlessException*", "*HTTP Error Code: 404*",],

  # TT Sampling
  $tt_sampling_enabled     = true,
  $tt_clamp                = 50,
  $tt_perinterval_count    = 1,
  $tt_interval_seconds     = 120,

  # Remote Configuration Settings
  $remoteagent_configuration_enabled             = true,
  $remoteagent_configuration_allowed_files       = 'domainconfig.xml',

  # Bootstrap Classes Instrumentation Manager
  $bootstrap_classes_manager_enabled             = true,
  $bootstrap_classes_manager_wait_at_startup     = 240,

  # Remote Dynamic Instrumentation Settings
  $remoteagent_dynamic_instrumentation_enabled   = true,

  # Dynamic Instrumentation Settings
  $autoprobe_dynamicinstrument_enabled           = true,

  # Deep Inheritance Settings
  $autoprobe_deepinheritance_enabled             = true,
  $autoprobe_deepinheritance_auto_turnoff_enable = true,
  $autoprobe_deepinheritance_auto_turnoff_requests_per_interval = 100,
  $autoprobe_deepinheritance_auto_turnoff_maxtime_per_interval  = 12000,
  $autoprobe_deepinheritance_auto_turnoff_maxtime_total         = 120000,

  # Metric Aging
  $metric_aging_enable     = true,
  $metric_aging_exclude_for_websphere            = ["Threads*", "ChangeDetector.AgentID",],
  $metric_aging_exclude_for_weblogic             = [
    "Threads*",
    "ChangeDetector.AgentID",
    "WebLogic|Servlet Subsystem:Error Response Count",
    "WebLogic|HTTP Sessions Subsystem|All Sessions:Session Count",
    "WebLogic|HTTP Sessions Subsystem|Cookie Sessions:Session Count",
    "WebLogic|HTTP Sessions Subsystem|File Sessions:Session Count",
    "WebLogic|HTTP Sessions Subsystem|JDBC Sessions:Session Count",
    "WebLogic|HTTP Sessions Subsystem|Memory Sessions:Session Count",
    "WebLogic|HTTP Sessions Subsystem|Replicated Sessions:Session Count",
    "WebLogic|Clustering|Change Event:Count",
    "WebLogic|Clustering|Full State Dump:Count",
    "WebLogic|Clustering|Announce:Count",
    "WebLogic|Clustering|Peer Gone Listeners:Count",
    "WebLogic|Clustering|RJVM Remote Call:Error Count",
    "WebLogic|XML Subsystem|SAX Parsers:Creation Count",
    "WebLogic|XML Subsystem|Document Builder:Creation Count",
    "WebLogic|XML Subsystem|SAX Transformer:Creation Count",
    ],

  # Servlet Header Decorator
  $decorator_enabled       = false,
  $decorator_security      = 'encrypted',

  # ChangeDetector configuration
  $changedetector_enable   = false,
  $changedetector_root_dir = './changedetector',
  $changedetector_agent_id = undef,
  $changedetector_profile  = './common/ChangeDetector-config.xml',
  $changedetector_profile_dir      = 'changeDetector_profiles',

  # Application Map Agent Side
  $appmap_enabled          = true,
  $appmap_metrics_enabled  = true,
  $appmap_catalystIntegration_enabled            = false,
  $appmap_queue_size       = 1000,
  $appmap_queue_period     = 1000,
  $appmap_intermediate_nodes_enabled             = false,
  $appmap_levels_enabled   = 'MethodClass',
  $appmap_owners_enabled   = 'Application,BusinessTransactionComponent',

  # Application Map and Socket
  $appmap_sockets_managed_reportToAppmap         = true,
  $appmap_sockets_managed_reportClassAppEdge     = false,
  $appmap_sockets_managed_reportMethodAppEdge    = true,
  $appmap_sockets_managed_reportClassBTEdge      = false,
  $appmap_sockets_managed_reportMethodBTEdge     = true,

  # Business Recording
  $bizRecording_enabled    = true,

  # Powerpack for SiteMinder Web Access Manager
  $siteminder_webagent_tracethreshold            = 5000,

  # Garbage collection and Memory Monitoring
  $gcmonitor_enable        = true,

  # Thread Dump Collection
  $threaddump_enable       = true,
  $threaddump_max_stack_elements   = 25000,
  $threaddump_deadlockpoller_enable              = true,
  $threaddump_deadlockpoller_interval            = 15000,

  # Sustainability metrics
  $blame_transactions_debugmetrics_enabled       = false,
  $harvesting_debugmetrics_enabled = false,
  $concurrentMapPolicy_generatemetrics           = false,

  # Smart Instrumentation properties
  $deep_instrumentation_enabled    = true,
  $deep_trace_enabled      = true,
  $deep_instrumentation_level      = 'low',
  $deep_instrumentation_level_batch_size         = 5,
  $deep_instrumentation_level_batch_interval     = 2,
  $deep_errorsnapshot_enable       = true,
  $deep_stallsnapshot_enabled      = true,
  $deep_instrumentation_max_methods              = 10000,
  $deep_trace_max_components       = 1000,
  $deep_trace_max_consecutive_components         = 15,
  $deep_instrumentation_custom_prefixes          = 'java',
  $deep_automatic_trace_enabled    = true,
  $deep_automatic_trace_clamp      = 10,
  $deep_entrypoint_enabled = true,
  $deep_entrypoint_skip_pkgs       = undef,
  $deep_entrypoint_count_max       = 100,

  # External Business Transaction Monitoring properties
  $external_biz_enable     = true,
  $external_biz_header_size_max    = 10,
  $external_biz_bt_count_max       = 100,

  # BRTM Business Transaction Monitoring properties
  $brtm_enabled            = false,
  $brtm_snippet_insertion_enabled  = true,
  $brtm_exclude_url_list   = undef,
  $brtm_js_funtion_metrics_enabled = false,
  $brtm_geolocation_enabled        = false,

  $collector_groups = undef,
  $connection_order = 'DEFAULT',
  $assigned_collector_group = 'group2',
  $notify_enabled  = false,



  $puppet_src = "puppet:///modules/${module_name}",

)
#inherits caapm::agent::defaults
{

  $agent_pkg = "IntroscopeAgentANZ${version}.tar.gz"


  if $notify_enabled {
    notify {"Running agent with agents_dir = $agents_dir":}
    notify {"Running agent with logs_dir = $logs_dir":}
    notify {"Running agent with stage_dir = $stage_dir":}
  }

  include caapm::agent::install
  include caapm::agent::config
  include caapm::agent::service

  Class['caapm::agent::install'] ->
  Class['caapm::agent::config']  ->
  Class['caapm::agent::service']

  anchor {
    'caapm::agent::begin':
       before  => Class['caapm::agent::install','caapm::agent::config'],
       notify  => Class['caapm::agent::service'];
    'caapm::agent::end':
       require => Class['caapm::agent::service'];
  }

}
