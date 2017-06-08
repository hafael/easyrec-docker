#!/bin/bash

#

# tomcat        

#

# chkconfig: 

# description:  Start up the Tomcat servlet engine.

# Source function library.

. /lib/lsb/init-functions

RETVAL=$?

CATALINA_HOME="/opt/tomcat"

case "$1" in

 start)

        if [ -f $CATALINA_HOME/bin/startup.sh ];

          then

   echo $"Starting Tomcat... "

           /bin/su -s /bin/bash tomcat $CATALINA_HOME/bin/startup.sh

        fi

;;

 stop)

        if [ -f $CATALINA_HOME/bin/shutdown.sh ];

          then

   echo $"Stopping Tomcat... "

            /bin/su tomcat $CATALINA_HOME/bin/shutdown.sh

        fi

  ;;
  restart)

        if [ -f $CATALINA_HOME/bin/shutdown.sh ];

          then

   echo $"Stopping Tomcat... "

            /bin/su tomcat $CATALINA_HOME/bin/shutdown.sh

        fi
        if [ -f $CATALINA_HOME/bin/startup.sh ];

          then

   echo $"Starting Tomcat... "

           /bin/su -s /bin/bash tomcat $CATALINA_HOME/bin/startup.sh

        fi

  ;;

 *)

  echo $"Usage: $0 {start|stop|restart|version}"

exit 1

;;

esac

exit $RETVAL