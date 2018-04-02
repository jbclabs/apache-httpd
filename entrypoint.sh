#! /bin/sh
# jbc labs generic entrypoint.sh

echo "Printing build log"
cat /tmp/build.log

# Apache gets grumpy about PID files pre-existing
rm -f /usr/local/apache2/logs/httpd.pid

# Running Apache in foreground
exec httpd -DFOREGROUND