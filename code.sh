#!/bin/bash

# Aktuelle Zeit und Datum wird in Variablen gespeichert
stunde=$(date +%H)      # um zu wissen, ob die Beleuchtung ausgeschaltet werden muss
datum=$(date +%R-%d/%m/%y)

# Check, ob Datenbank erreichbar ist! Wenn nicht, ausgabe am Display
if ! /opt/wetter/wetter_mysql/dbcheck.sh; then
lcd2=" DB nicht erreichbar"
lcd3="  letzter Check:"
lcd4="  ${datum}"

else

#Werte aus den einzelnen Bricklets in Variablen speichern
TEMPIN=`/opt/wetter/wetter_mysql/1temp30.sh`
echo "Temp Innen: "$TEMPIN

TEMPOUT=`/opt/wetter/wetter_mysql/2temp1.sh`
echo "TEMP Aussen: "$TEMPOUT

# LCD-Zeile 1 wird beschrieben
lcd1="Temp I ${TEMPIN}|A ${TEMPOUT}"

HUMIN=`/opt/wetter/wetter_mysql/1hum30.sh`
echo "Hum Innen: "$HUMIN

HUMOUT=`/opt/wetter/wetter_mysql/2hum1.sh`
echo "Hum Aussen: "$HUMOUT

# LCD-Zeile 2 wird beschrieben
lcd2="Hum  I ${HUMIN} |A ${HUMOUT}"

PRESSIN=`/opt/wetter/wetter_mysql/1press30.sh`
echo "Press Innen: "$PRESSIN


AMBOUT=`/opt/wetter/wetter_mysql/2amb1.sh`
echo "Amb Aussen: "$AMBOUT

# LCD-Zeile 3 wird beschrieben
lcd3="P ${PRESSIN}|Amb ${AMBOUT}"

datum1=`/opt/wetter/wetter_mysql/lastdate.sh`
datum=$(echo $datum1 | cut -c 3-16 )
#LCD4 wird mit Daten befüllt
lcd4="DB: ${datum}"

fi

#
######
# Display in Variable speichern
uidlcd=eWx         # Display 20x4




#
#######
#
# Clear Display
/usr/local/bin/tinkerforge call lcd-20x4-bricklet $uidlcd clear-display

/usr/local/bin/tinkerforge call lcd-20x4-bricklet $uidlcd backlight-on

# write aktuellen Werte auf Display
/usr/local/bin/tinkerforge call lcd-20x4-bricklet $uidlcd write-line 0 0 "$lcd1"
/usr/local/bin/tinkerforge call lcd-20x4-bricklet $uidlcd write-line 1 0 "$lcd2"
/usr/local/bin/tinkerforge call lcd-20x4-bricklet $uidlcd write-line 2 0 "$lcd3"
/usr/local/bin/tinkerforge call lcd-20x4-bricklet $uidlcd write-line 3 0 "$lcd4"

echo "### Ausgabe Daten"
echo $lcd1
echo $lcd2
echo $lcd3
echo $lcd4

# Wenn Stunde mehr als 20 ist, wird das Backlight ausgeschalten - der letzte macht das Licht aus
if [ "$stunde" -gt "20" ]
   then /usr/local/bin/tinkerforge call lcd-20x4-bricklet $uidlcd backlight-off
fi

exit

