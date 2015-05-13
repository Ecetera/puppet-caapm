#!/bin/sh
#
# WVCtrl.sh
# Control script for running the Introscope WebView
# as a Unix service via an easy-to-use command line interface  
# Usage:
# WVCtrl.sh start
# WVCtrl.sh stop
# WVCtrl.sh status
# WVCtrl.sh help
#
# The exit codes returned are:
#	0 - operation completed successfully
#	1 - 
#	2 - usage error
#	3 - WebView could not be started
#	4 - WebView could not be stopped
#	8 - configuration syntax error
#
# When multiple arguments are given, only the error from the _last_
# one is reported.
#
# Run "WVCtrl.sh help" for usage info

# RECOMMENDED WV CONFIGURATION
# 1. In the Introscope WebView.lax file, change the value of the
# lax.stdin.redirect to <blank>, as in:
# lax.stdin.redirect=
# 2. In the IntroscopeWebView.properties file, ensure that the
# property introscope.enterprisemanager.disableInteractiveMode is set to
# true, as in:
# introscope.enterprisemanager.disableInteractiveMode=true
#
# |||||||||||||||||||| START CONFIGURATION SECTION  ||||||||||||||||||||

THIS_OS=`uname -a | awk '{print $1}'`
case $THIS_OS in
HP-UX)	
    if ! [ "$WILYHOME" ] ; then
		WILYHOME="`pwd`/.."; export WILYHOME
		cd "${WILYHOME}"
		cd .
		WILYPARENT="`pwd`"; export WILYPARENT
		cd "${WILYHOME}"		
				
    fi
    ;;
*)
    if [ -z "$WILYHOME" ]; then
		WILYHOME="`pwd`/.."; export WILYHOME
		cd "${WILYHOME}"
		cd .
		WILYPARENT="`pwd`"; export WILYPARENT
		cd "${WILYHOME}"					
    fi
    ;;
esac

# The logfile
## Devsh03- moving it to logs folder so that all log files are located at a single place.
## Redirecting the console log is still important as we can capture failures 
## that happen before logging framework is initialized
mkdir -p ${WILYHOME}/logs
LOGFILE="${WILYHOME}/logs/em.log"
LOGFILE1="${WILYHOME}/logs/IntroscopeWebView.log"

# the path to your PID file
PIDFILE="${WILYHOME}/wv.pid"

case $THIS_OS in
OS400)
    WVCmd="${WILYHOME}/runem.sh"
    ;;
*)
    WVCmd="${WILYHOME}/Introscope_WebView"
    ;;
esac


# ||||||||||||||||||||   END CONFIGURATION SECTION  ||||||||||||||||||||
 
cd "${WILYHOME}"

ERROR=0
ARGV="$@"
if [ "x$ARGV" = "x" ] ; then 
    ARGS="help"
fi

for ARG in $@ $ARGS
do
#
# 1. Check whether PID file is available / not ?
#	 if true	--> check whether the PID stored in the PID file is running / not ?
#					if true --> set the flags [PROCESS_RUNNING, PIDSTATUS] and break
# 					else	--> remove the PID file, unset the flag [PIDSTATUS] and call 'function_Introscope'
#	 else		-->	unset the flag [PIDSTATUS] and call 'function_Introscope'						
#
# 2. In 'function_Introscope' 
#	 check if any java process has the path of the Introscope_WebView in its arguments / not ?
#	 if true	--> write that PID into the PID file and set the flag [PROCESS_RUNNING]
# 	 else		--> unset the flag [PROCESS_RUNNING]

#
# Check whether the WV is already running / not
#
function_Introscope(){

flag_pid=-1

THIS_OS=`uname -a | awk '{print $1}'`
case $THIS_OS in
SunOS) 
	array_Java="`UNIX95= ps -Aeo pid,args | grep "[j]ava" | sed 's/^[ \t]*//' | cut -d' ' -f1`"
#     
# In grep - [?] is a character class of one letter and will be removed when parsed by the shell.
# This is useful while parsing the output of grep and using the return value in an if-statement 
# without having its own process causing it to erroneously return TRUE.
# 		
	for variable_iterator in $array_Java
	do
	eval pid_value$n="$variable_iterator"	
	variable_string="`eval echo "\$pid_value$n"`"
	temp="`pargs -l $variable_string | grep "[I]ntroscope_WebView.lax"`"
	temp1="`pargs -l $variable_string | grep "$WILYPARENT"`"
	
	if [ "$temp" ] && [ $variable_string -ge 0 ] && [ "$temp1" ] ; then
			flag_pid=$variable_string			
				break;
	else
		flag_pid=-1	
	fi
	done
	
	if [ "$flag_pid" -gt -1 ]; then	
		PID=$flag_pid			
		echo "$PID" > "$PIDFILE"			
		PROCESS_RUNNING=1			
	else
		PROCESS_RUNNING=0
		flag_pid=-1
	fi	
    ;;
	
HP-UX)
	flag_pid="`UNIX95= ps -Aexo pid,args | grep "[j]ava" | grep ${WILYPARENT} | grep "[I]ntroscope_WebView.lax" | sed 's/^[ \t]*//' | cut -d' ' -f1`"
#
# UNIX95=[space] specifies to use the XPG4 behavior for this command because options like 'ps -o','args'
# are illegal by default in HP-UX systems. 
#
	if [ ${flag_pid:- -1} -gt -1 ]; then	
		PID=$flag_pid			
		echo "$PID" > "$PIDFILE"			
		PROCESS_RUNNING=1			
	else
		PROCESS_RUNNING=0
		flag_pid=-1
	fi	
	;;
	
*)   
	flag_pid="`ps -Aeo pid,args | grep "[j]ava" | grep ${WILYPARENT} | grep "[I]ntroscope_WebView.lax" | sed 's/^[ \t]*//' | cut -d' ' -f1`"	
	if [ ${flag_pid:- -1} -gt -1 ]; then	
		PID=$flag_pid			
		echo "$PID" > "$PIDFILE"			
		PROCESS_RUNNING=1			
	else
		PROCESS_RUNNING=0
		flag_pid=-1
	fi	
	;;
esac
#
# Don't use '>' as an aliter for '-gt' in the if-statement; it fails on some platforms and sometimes creates an empty file naming it with 
# the value given on the right hand side of '>' (here '-1')
#
	
}

#
# Check whether PID file is available / not ?
#
	if [ -f "$PIDFILE" ] ; then
		PID=`cat "$PIDFILE"`
		if [ "x$PID" != "x" ] && kill -0 $PID 2>/dev/null ; then	
			STATUS="WebView (pid $PID) running"
			PIDSTATUS=1
			PROCESS_RUNNING=1
		else
			STATUS="WebView (pid $PID?) not running"	  
			rm "$PIDFILE"		
			PIDSTATUS=0
			function_Introscope
	fi
	else
		STATUS="WebView (no pid file) not running"	
		PIDSTATUS=0	
		function_Introscope
fi
	
	case $ARG in
	
	start)
	if [ "$PROCESS_RUNNING" -eq 1 ]; then
	    echo "$0 $ARG: WebView (pid $PID) already running"
		
	    continue
	fi	
	if [ "$PIDSTATUS" -eq 0 ]; then
	nohup "$WVCmd" >> "$LOGFILE" 2>&1 &
	if [ "x$!" != "x" ] ; then
		echo "$!" > "$PIDFILE"
	    echo "$0 $ARG: Starting WebView..."
	    echo "(Please wait a few minutes for initialization to complete.)"
	    echo "Please check log file for more details."
	else
	    echo "$0 $ARG: WebView could not be started"
	    ERROR=3
	fi
	fi
	;;
	
	stop)
	if [ "$PROCESS_RUNNING" -eq 0 ]; then
		    echo "$0 $ARG: $STATUS"
			
	    continue
	fi
	if kill $PID ; then
		echo "$0 $ARG: Stopping WebView..."
			while [ "${?}" -eq 0 ]		# Repeat until the WV process has terminated
			do	
				ps -p $PID >/dev/null	# Check if the WV process has terminated
			done		
		rm "$PIDFILE"
	    echo "$0 $ARG: WebView stopped"
	    echo "$0 $ARG: WebView stopped" >> $LOGFILE
	    echo "$0 $ARG: WebView stopped" >> $LOGFILE1		
	else
	    echo "$0 $ARG: WebView (pid $PID) could not be stopped"
	    ERROR=4
	fi
	;; 
		
	status)
    	if [ "$PROCESS_RUNNING" -eq 1 ]; then
    		echo "$0 $ARG: WebView (pid $PID) is running"
    	else
    		echo "$0 $ARG: WebView stopped"
		    echo "$0 $ARG: WebView stopped" >> $LOGFILE
	    	echo "$0 $ARG: WebView stopped" >> $LOGFILE1		
    	fi
    	;;  
    
	*)
	echo "usage: $0 (start|stop|help)"
	cat <<EOF

status     - status of the WebView
start      - start WebView
stop       - stop WebView
help       - this screen

EOF
	ERROR=2
    ;;

    esac

done

exit $ERROR
