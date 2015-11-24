#!/bin/bash

# Variablen festlegen
dbserver=192.168.24.2
dbuser=wetter
dbpassword=wetter
dbused=wetterstation

#login to database via user root and passwort PASSWORD
mysql -h $dbserver -u $dbuser -p$dbpassword -e 'use wetterstation'

