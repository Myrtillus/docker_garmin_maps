#!/bin/sh

cd /Garmin_OSM_TK_maps

# Update the style files before generation................
#sudo -u nissiant git pull

# TAMPERE
#################
#################


# Retrieving OSM data and splitting to manageable size
#######################################################

# get the osm data file

#wget -O tampere.osm "http://overpass.osm.rambler.ru/cgi/xapi_meta?*[bbox=22.8, 61.05, 25, 61.7881]"
#wget -O tampere.osm "http://z.overpass-api.de/api/xapi_meta?*[bbox=      22.8, 61.05, 25, 61.7881]"


wget --user-agent Mozilla/5.0 --header="Host: kartta.arpotechno.fi" --header="Referer: http://kartta.arpotechno.fi (antti@myrtillus.net)" -O tampere.osm "http://www.overpass-api.de/api/xapi_meta?*[bbox=22.8,61.05,25,61.7881]"

sleep 10

# Split the osm file to smaller pieces

java -jar -Xmx1000m splitter.jar tampere.osm --precomp-sea=sea.zip --geonames-file=cities15000.zip --max-areas=2048 --max-nodes=1000000 --wanted-admin-level=8

# Fix the names in the template.args file descriptions, MAX 20 CHARACTERS
python3 fix_names.py TK_MTB_Tampere


# Create the gmapsupp map file, NOTE THE MAPNAME HAS TO UNIQUE, FAMILY ID IS ALSO UNIQUE

# kesa v√versio kartasta
java -jar -Xmx1000m mkgmap.jar --max-jobs --gmapsupp --latin1 --tdbfile --mapname=88880001 --description="OpenStreetMap-pohjainen MTB-kartta, Tampereen alue" --family-id=8888 --series-name="OSM MTB Suomi" --style-file=TK/ TK_Tampere.typ --cycle-map --precomp-sea=sea.zip --generate-sea --bounds=bounds.zip --remove-ovm-work-files -c template.args 

# talviversio kartasta
#java -jar -Xmx1000m mkgmap.jar --max-jobs --gmapsupp --latin1 --tdbfile --mapname=88880001 --description="OpenStreetMap-pohjainen MTB-kartta, Tampereen alue" --family-id=8888 --series-name="OSM MTB Suomi" --style-file=TK_W/ TK_Tampere.typ --cycle-map --precomp-sea=sea.zip --generate-sea --bounds=bounds.zip --remove-ovm-work-files -c template.args


# copy the map file to folder that is mapped to local host
mv gmapsupp.img /ready_maps/tk_tre.img

# Clean the directory
rm -f *.osm osmmap.* *.img *.pbf osmmap_license.txt template* densities* areas*

