#!/bin/sh

timeout=60
to_graphite(){
    GRAPHITE_HOST=${GRAPHITE_HOST:-heidi.shack}
    GRAPHITE_PORT=${GRAPHITE_PORT:-2003}
    now=$(date +%s)
    echo "$1 ${2} ${3:-$now}" | nc -c $GRAPHITE_HOST $GRAPHITE_PORT
}



# maybe we can just use mein.aramark.de/thales-deutschland/wp-admin/admin-ajax.php
val=$(curl --silent http://mein.aramark.de/thales-deutschland/auslastung/ | grep percentagevalue | sed -n 's/.*data-value="\([0-9,]*\)".*/\1/p' | tr , .)
echo "current last is $val"
if to_graphite ara.last $val;then
  echo "to_graphite successful"
else
  echo "to_graphite failed ..."
fi
