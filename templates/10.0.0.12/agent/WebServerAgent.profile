########################################################################
#                                                                      
# Introscope Agent Configuration
#                                                                      
# CA (tm) Introscope(R) PowerPack(tm) for Web Servers                    	
#																					 
#																					 
# CA Wily Introscope(R) Version 10.0.0 Build 990010									 
# Copyright (c) 2015 CA. All Rights Reserved.									 
# Introscope(R) is a registered trademark of CA.	
########################################################################



#################################
# Logging Configuration
#
# ================ 
# The following property, log4j.logger.IntroscopeAgent,
# controls both the amount of detail
# that is logged and the output location.  
# Replace the text 'INFO' with the much longer text shown below - 
# 'VERBOSE#com.wily.util.feedback.Log4JSeverityLevel' 
# to increase the level of detail.
# Replace 'console' with 'logfile' (without the quotes)
# to send the output to a log file instead of the console.

log4j.logger.IntroscopeAgent=<%= @logConfig_IntroscopeAgent %>
log4j.logger.WebServerMonitor=<%= @logConfig_WebServerMonitor %>
log4j.logger.AutoDiscoveryEngine=<%= @logConfig_AutoDiscoveryEngine %>
log4j.logger.AgentConfig=<%= @logConfig_AgentConfig %>
log4j.logger.UpdateMonitorConfig=<%= @logConfig_UpdateMonitorConfig %>

 
# If logfile is specified above, the location of the log file
# is configured with the following property,
# log4j.appender.logfile.File.  Full paths can
# be used if desired.

log4j.appender.logfile.File=<%= @logs_dir %>/WebServerAgent.log
 
########## See Warning below ##########
# Warning: The following properties should not be modified for normal use.
log4j.additivity.IntroscopeAgent=<%= @additivity_IntroscopeAgent %>
log4j.additivity.WebServerMonitor=<%= @additivity_WebServerMonitor %>
log4j.additivity.AutoDiscoveryEngine=<%= @additivity_AutoDiscoveryEngine %>
log4j.additivity.AgentConfig=<%= @additivity_AgentConfig %>
log4j.additivity.UpdateMonitorConfig=<%= @additivity_UpdateMonitorConfig %>
log4j.appender.console=<%= @appender_console %>
log4j.appender.console.layout=<%= @appender_console_layout %>
log4j.appender.console.layout.ConversionPattern=<%= @appender_console_layout_ConversionPattern %>
log4j.appender.console.target=<%= @appender_console_target %>
log4j.appender.logfile=<%= @appender_logfile %>
log4j.appender.logfile.layout=<%= @appender_logfile_layout %>
log4j.appender.logfile.layout.ConversionPattern=<%= @appender_logfile_layout_conversionPattern %>
log4j.appender.logfile.MaxBackupIndex=<%= @appender_logfile_maxBackupIndex %>
log4j.appender.logfile.MaxFileSize=<%= @appender_logfile_maxFileSize %>
#########################################


#################################
# Enterprise Manager Connection Order
#
# ================
# The Enterprise Manager connection order list the Agent uses if it 
# is disconnected from its Enterprise Manager.

introscope.agent.enterprisemanager.connectionorder=<%= @connection_order %>


#################################
# Enterprise Manager Locations and Names 
# (names defined in this section are only used in the 
# introscope.agent.enterprisemanager.connectionorder property)
#
# ================
# Settings the Introscope Agent uses to find the Enterprise Manager 
# and names given to host and port combinations.

#introscope.agent.enterprisemanager.transport.tcp.host.DEFAULT=localhost
#introscope.agent.enterprisemanager.transport.tcp.port.DEFAULT=5001


# The following connection properties enable the Agent to tunnel communication 
# to the Enterprise Manager over HTTP.
#
# WARNING: This type of connection will impact Agent and Enterprise Manager 
# performance so it should only be used if a direct socket connection to the 
# the Enterprise Manager is not feasible. This may be the case if the Agent 
# is isolated from the Enterprise Manager with a firewall blocking all but 
# HTTP traffic.
# 
# When enabling the HTTP tunneling Agent, uncomment the following host, port, 
# and socket factory properties, setting the host name and port for the 
# Enterprise Manager Web Server. Comment out any other connection properties 
# assigned to the "DEFAULT" channel and confirm that the "DEFAULT" channel is 
# assigned as a value for the "introscope.agent.enterprisemanager.connectionorder" 
# property.
# You must restart the managed application before changes to this property take effect.
#introscope.agent.enterprisemanager.transport.tcp.host.DEFAULT=localhost
#introscope.agent.enterprisemanager.transport.tcp.port.DEFAULT=8081
#introscope.agent.enterprisemanager.transport.tcp.socketfactory.DEFAULT=com.wily.isengard.postofficehub.link.net.HttpTunnelingSocketFactory

# The following properties are used only when the Agent is tunneling over HTTP 
# and the Agent must connect to the Enterprise Manager through a proxy server 
# (forward proxy). Uncomment and set the appropriate proxy host and port values. 
# If the proxy server cannot be reached at the specified host and port, the 
# Agent will try a direct HTTP tunneled connection to the Enterprise Manager 
# before failing the connection attempt.
# You must restart the managed application before changes to this property take effect.
#introscope.agent.enterprisemanager.transport.http.proxy.host=
#introscope.agent.enterprisemanager.transport.http.proxy.port=

# The following properties are used only when the proxy server requires 
# authentication. Uncomment and set the user name and password properties.
# You must restart the managed application before changes to this property take effect.
#introscope.agent.enterprisemanager.transport.http.proxy.username=
#introscope.agent.enterprisemanager.transport.http.proxy.password=

# To connect to the Enterprise Manager using HTTPS (HTTP over SSL),
# uncomment these properties and set the host and port to the EM's secure https listener host and port.
#introscope.agent.enterprisemanager.transport.tcp.host.DEFAULT=localhost
#introscope.agent.enterprisemanager.transport.tcp.port.DEFAULT=8444
#introscope.agent.enterprisemanager.transport.tcp.socketfactory.DEFAULT=com.wily.isengard.postofficehub.link.net.HttpsTunnelingSocketFactory

# To connect to the Enterprise Manager using SSL,
# uncomment these properties and set the host and port to the EM's SSL server socket host and port.
#introscope.agent.enterprisemanager.transport.tcp.host.DEFAULT=localhost
#introscope.agent.enterprisemanager.transport.tcp.port.DEFAULT=5443
#introscope.agent.enterprisemanager.transport.tcp.socketfactory.DEFAULT=com.wily.isengard.postofficehub.link.net.SSLSocketFactory


# Additional properties for connecting to the Enterprise Manager using SSL.
#
# Location of a truststore containing trusted EM certificates.
# If no truststore is specified, the agent trusts all certificates.
# Either an absolute path or a path relative to the agent's working directory.
# On Windows, backslashes must be escaped.  For example: C:\\keystore
#introscope.agent.enterprisemanager.transport.tcp.truststore.DEFAULT=
# The password for the truststore
#introscope.agent.enterprisemanager.transport.tcp.trustpassword.DEFAULT=
# Location of a keystore containing the agent's certificate.
# A keystore is needed if the EM requires client authentication.
# Either an absolute path or a path relative to the agent's working directory.
# On Windows, backslashes must be escaped.  For example: C:\\keystore
#introscope.agent.enterprisemanager.transport.tcp.keystore.DEFAULT=
# The password for the keystore
#introscope.agent.enterprisemanager.transport.tcp.keypassword.DEFAULT=
# Set the enabled cipher suites.
# A comma-separated list of cipher suites.
# If not specified, use the default enabled cipher suites.
#introscope.agent.enterprisemanager.transport.tcp.ciphersuites.DEFAULT=

<% @collector_groups.each do |groupkey, group_data| -%>
<%   if groupkey == @assigned_collector_group -%>
<%     group_data.each do |key, fields| -%>
<%       fields.each do |field, value| -%>
introscope.agent.enterprisemanager.transport.tcp.<%= field %>.<%= key %>=<%= value %>
<%       end -%>

<%     end -%>
<%   end -%>
<% end -%>


#################################
# Enterprise Manager Failback Retry Interval
#
# ================
# When the Agent is configured to have multiple Enterprise Managers
# in its connection order and this property is enabled, the Introscope 
# Agent will automatically attempt to reconnect to the first Enterprise
# Manager in its connection order when it is connected to any other
# Enterprise Manager. The reconnection attempt will occur on a regular
# interval as specified.

#introscope.agent.enterprisemanager.failbackRetryIntervalInSeconds=<%= @failbackRetryInterval %>


#######################
# Custom Process Name
#
# ================
# Specify the process name as it appears in the
# Introscope Enterprise Manager and Workstation.

introscope.agent.customProcessName=<%= @ppwebserver_customProcessName %>


#######################
# Agent Name
#
# ================
# Specify the name of this agent as it appears in the
# Introscope Enterprise Manager and Workstation.

# This Agent Name is used if the other methods are disabled or fail.
introscope.agent.agentName=<%= @ppwebserver_agentName %>


#######################
# Agent Thread Priority
#
# ================
# Controls the priority of agent threads.  Varies
# from 1 (low) to 10 (high). Default value if unspecified is Thread.NORM_PRIORITY (5)

#introscope.agent.thread.all.priority=5


#######################
# Agent Metric Clamp Configuration
#
# ================
# The following setting configures the Agent to approximately clamp the number of metrics sent to the EM  
# If the number of metrics pass this metric clamp value then no new metrics will be created.  Old metrics will still report values.
# The value must be equal to or larger than 1000 to take effect. Lower value will be rejected.
# The default value is 50000. 
# You must restart the managed application before changes to this property take effect.
#introscope.agent.metricClamp=50000


#######################
# Agent Extensions Directory
#
# ================
# This property specifies the location of Supportability JAR to be loaded
# by the Introscope Agent for debugguing purposes.Non-absolute names are resolved relative 
# to the location of this properties file.

introscope.agent.extensions.directory=<%= @ppwebserver_extensions_directory %>



################################
# Agent Metric Aging
# ==============================
# Detects metrics that are not being updated consistently with new data and removes these metrics.
# By removing these metrics you can avoid metric explosion.    
# Metrics that are in a group will be removed only if all metrics under this group are considered candidates for removal.
# BlamePointTracer metrics are considered a group.  
#
# Enable/disable the metric agent aging feature. 
# Changes to this property take effect immediately and do not require the managed application to be restarted.
introscope.agent.metricAging.turnOn=<%= @ppwebserver_metricAging_turnOn %>
#
# The time interval in seconds when metrics are checked for removal
# You must restart the managed application before changes to this property take effect.
introscope.agent.metricAging.heartbeatInterval=<%= @ppwebserver_metricAging_heartbeatInterval %>
#
# During each interval, the number of metrics that are checked for metric removal
# Changes to this property take effect immediately and do not require the managed application to be restarted.
introscope.agent.metricAging.dataChunk=<%= @ppwebserver_metricAging_dataChunk %>
#
# The metric becomes a candidate for removal when it reaches the number of intervals set (numberTimeslices) and has not invoked any new data points during that period.  
# If the metric does invoke a new data point during that period then the numberTimeslices resets and starts over.  
# Changes to this property take effect immediately and do not require the managed application to be restarted.
introscope.agent.metricAging.numberTimeslices=<%= @ppwebserver_metricAging_numberTimeslices %>
#
# You can choose to ignore metrics from removal by adding the metric name or metric filter to the list below.  
# Changes to this property take effect immediately and do not require the managed application to be restarted.
#introscope.agent.metricAging.metricExclude.ignore.0=Threads*