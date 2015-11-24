#!/bin/bash

# Variablen festlegen
dbserver=192.168.24.2
dbuser=wetter
dbpassword=wetter#2013
dbused=wetterstation
ausgabe1=xxx

verarbeite_ausgabe(){

  while read line; do
   echo "$line"
 done
}

#login to database via user root and passwort PASSWORD
mysql -N -r -B -h $dbserver -u $dbuser -p$dbpassword -D$dbused <<SQL_SCRIPT | verarbeite_ausgabe

#select column id and name from table  entry
SELECT wert FROM 1hum30 ORDER BY id DESC LIMIT 1;
\q
SQL_SCRIPT

