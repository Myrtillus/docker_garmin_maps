#!/bin/sh

cd /Garmin_OSM_TK_maps


# TAMPERE
#################
#################


# Retrieving OSM data and splitting to manageable size
#######################################################

# get the osm data file

#wget -O tampere.osm "http://overpass.osm.rambler.ru/cgi/xapi_meta?*[bbox=22.8, 61.05, 25, 61.7881]"
#wget -O tampere.osm "http://z.overpass-api.de/api/xapi_meta?*[bbox=      22.8, 61.05, 25, 61.7881]"



# pohjoinen tampere
wget --user-agent Mozilla/5.0 --header="Host: kartta.arpotechno.fi" --header="Referer: http://kartta.arpotechno.fi (antti@myrtillus.net)" -O tampere_pohjoinen.osm "http://www.overpass-api.de/api/xapi_meta?*[bbox=22.8 , 61.5 , 25 , 62]"

# etelainen tampere
wget --user-agent Mozilla/5.0 --header="Host: kartta.arpotechno.fi" --header="Referer: http://kartta.arpotechno.fi (antti@myrtillus.net)" -O tampere_etelainen.osm "http://www.overpass-api.de/api/xapi_meta?*[bbox=22.8 , 61 , 25 , 61.5]"

# yhdistetaan osm fileet
osmosis --rx tampere_pohjoinen.osm --rx tampere_etelainen.osm  --merge --wx tampere.osm



# Split the osm file to smaller pieces
#java -jar -Xmx1000m splitter.jar tampere.osm --precomp-sea=sea.zip --geonames-file=cities15000.zip --max-areas=2048 --max-nodes=1000000 --wanted-admin-level=8
java -jar -Xmx1000m splitter.jar tampere.osm\
 --description="Tampere Region"\
 --precomp-sea=sea.zip\
 --geonames-file=cities15000.zip\
 --max-areas=4096\
 --max-nodes=1000000\
 --mapid=48730001\
 --status-freq=2\
 --keep-complete=true



# Fix the names in the template.args file descriptions, MAX 20 CHARACTERS
python3 fix_names.py TK_MTB_Tampere


# Create the gmapsupp map file, NOTE THE MAPNAME HAS TO UNIQUE, FAMILY ID IS ALSO UNIQUE

java -jar -Xmx1000m mkgmap.jar\
 --max-jobs\
 --gmapsupp\
 --latin1\
 --tdbfile\
 --mapname=88880001\
 --description="OpenStreetMap-pohjainen MTB-kartta, Tampereen alue"\
 --family-id=8888\
 --series-name="OSM MTB Suomi"\
 --style-file=TK/ TK_Tampere.typ\
 --cycle-map\
 --precomp-sea=sea.zip\
 --generate-sea\
 --bounds=bounds.zip\
 --remove-ovm-work-files\
 -c template.args 



# copy the map file to folder that is mapped to local host
mv gmapsupp.img /ready_maps/tk_tre.img

# Clean the directory
#rm -f *.osm osmmap.* *.img *.pbf osmmap_license.txt template* densities* areas*
rm -f  osmmap.* *.img *.pbf osmmap_license.txt template* densities* areas*

