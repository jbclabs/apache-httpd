#! /bin/sh
# jbc labs generic Apache build script


#Log everything in /tmp/build.log
logfile=/tmp/build.log
exec > $logfile 2>&1
set -x

#check inside code artifact for /code/apache-conf/httpd.conf and use it if exists
#customizing Apache through providing apache-conf/httpd.conf as part of the code artifact
if [ -e /code/apache-conf/httpd.conf ]
then
 cp -f /code/apache-conf/httpd.conf /usr/local/apache2/conf/httpd.conf
else
 echo "Could not find /code/apache-conf/httpd.conf, going to use the default httpd.conf "
fi

cp -rf /code/* /usr/local/apache2/htdocs/

#Cleaning up after ourselves
rm -rf /code
#rm -rf /conf