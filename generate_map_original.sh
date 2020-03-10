#!/bin/bash
#
# mktiles.sh
#
# Exit on error
set -o errexit
set -o nounset


cd /home/nissiant/Garmin_OSM_TK_map

# Update the style files before generation
sudo -u nissiant git pull

# TAMPERE
#################
#################


# Retrieving OSM data and splitting to manageable size
#######################################################

# get the osm data file

#wget -O tampere.osm "http://overpass.osm.rambler.ru/cgi/xapi_meta?*[bbox=22.8, 61.05, 25, 61.7881]"

sudo wget --user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0" --keep-session-cookies --save-cookies cookies.txt --header="Host: kartta.arpotechno.fi" --header="Referer: http://kartta.arpotechno.fi (antti@myrtillus.net)" -O tampere.osm "http://www.overpass-api.de/api/xapi_meta?*[bbox=     22.8, 61.05, 25, 61.7881]" --header="Referer:http://kartta.arpotechno.fi (antti@myrtillus.net)"

#wget -O tampere.osm "http://z.overpass-api.de/api/xapi_meta?*[bbox=      22.8, 61.05, 25, 61.7881]"


# Split the osm file to smaller pieces


#java -jar -Xmx1000m splitter.jar tampere.osm --precomp-sea=sea.zip --geonames-file=cities15000.zip --max-areas=4096 --max-nodes=3000000 --wanted-admin-level=8

java -jar -Xmx1000m splitter.jar tampere.osm --precomp-sea=sea.zip --geonames-file=cities15000.zip --max-areas=2048 --max-nodes=1000000 --wanted-admin-level=8

#java -jar -Xmx1000m splitter.jar tampere.osm --precomp-sea=sea.zip --geonames-file=cities15000.zip --max-areas=1024 --max-nodes=500000 --wanted-admin-level=8

# Fix the names in the template.args file descriptions, MAX 20 CHARACTERS


python fix_names.py TK_MTB_Tampere


# Create the gmapsupp map file, NOTE THE MAPNAME HAS TO UNIQUE, FAMILY ID IS ALSO UNIQUE

# 6.11.2016 poistettu koodi. Aiheuttaa haamupolkuja overlayerien takia

# java -jar -Xmx1000m mkgmap.jar --max-jobs --gmapsupp --latin1 --tdbfile --nsis --mapname=88880001 --family-id=8888 --style-file=TK/ --precomp-sea=sea.zip --generate-sea --route --drive-on=detect,right --process-destination --process-exits --index --bounds=bounds.zip --location-autofill=is_in,nearest --x-split-name-index --housenumbers --remove-ovm-work-files -c template.args TK_Tampere.typ

# 6.11.2016 uusi versio, jonka pitaisi estaa haamuviivojen syntyminen


# kesa v√versio kartasta
java -jar -Xmx1000m mkgmap.jar --max-jobs --gmapsupp --latin1 --tdbfile --mapname=88880001 --description="OpenStreetMap-pohjainen MTB-kartta, Tampereen alue" --family-id=8888 --series-name="OSM MTB Suomi" --style-file=TK/ TK_Tampere.typ --cycle-map --precomp-sea=sea.zip --generate-sea --bounds=bounds.zip --remove-ovm-work-files -c template.args 

# talviversio kartasta
#java -jar -Xmx1000m mkgmap.jar --max-jobs --gmapsupp --latin1 --tdbfile --mapname=88880001 --description="OpenStreetMap-pohjainen MTB-kartta, Tampereen alue" --family-id=8888 --series-name="OSM MTB Suomi" --style-file=TK_W/ TK_Tampere.typ --cycle-map --precomp-sea=sea.zip --generate-sea --bounds=bounds.zip --remove-ovm-work-files -c template.args

# copy the map file to /var/www for downloading and clean up the directory


mv gmapsupp.img tk_tre.img


sudo chown www-data:www-data tk_tre.img


sudo mv -f tk_tre.img /var/www




# Clean the directory
rm -f *.osm osmmap.* *.img *.pbf osmmap_license.txt template* densities* areas*


sleep 900

# OULU
#################
#################


# Retrieving OSM data directly and generating map
#################################################

# Get the osm datafile

#wget -O oulu.osm "http://overpass.osm.rambler.ru/cgi/xapi_meta?*[bbox=24.5 ,64.7, 26.2, 65.25]"
sudo wget --user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0" --keep-session-cookies --save-cookies cookies.txt --header="Host: kartta.arpotechno.fi" --header="Referer: http://kartta.arpotechno.fi (antti@myrtillus.net)" -O oulu.osm "http://www.overpass-api.de/api/xapi_meta?*[bbox=     24.5 ,64.7, 26.2, 65.25]"  --header="Referer:http://kartta.arpotechno.fi (antti@myrtillus.net)"

# Split the osm file to smaller pieces

java -jar -Xmx1000m splitter.jar oulu.osm --precomp-sea=sea.zip --geonames-file=cities15000.zip --max-areas=2048 --max-nodes=1000000 --wanted-admin-level=8

# Fix the names in the template.args file descriptions, MAX 20 CHARACTERS

python fix_names.py TK_MTB_Oulu

# Create the gmapsupp map file, NOTE THE MAPNAME HAS TO UNIQUE, FAMILY ID IS ALSO UNIQUE

java -jar -Xmx1000m mkgmap.jar --max-jobs --gmapsupp --latin1 --tdbfile --nsis --mapname=88880002 --family-id=8888 --style-file=TK/ --precomp-sea=sea.zip --generate-sea --route --drive-on=detect,right --process-destination --process-exits --index --bounds=bounds.zip --location-autofill=is_in,nearest --x-split-name-index --housenumbers --remove-ovm-work-files -c template.args TK_Oulu.typ

# copy the map file to /var/www for downloading
mv gmapsupp.img tk_oulu.img
sudo chown www-data:www-data tk_oulu.img
sudo mv -f tk_oulu.img /var/www



sleep 900

# LAHTI
#################
#################


# Retrieving OSM data directly and generating map
#################################################

# Get the osm datafile

#wget -O lahti.osm "http://overpass.osm.rambler.ru/cgi/xapi_meta?*[bbox=24.98314, 60.87659, 26.28208, 61.37907]"
#wget -O lahti.osm "http://www.overpass-api.de/api/xapi_meta?*[bbox=    24.98314, 60.87659, 26.28208, 61.37907]"
sudo wget --user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0" --keep-session-cookies --save-cookies cookies.txt --header="Host: kartta.arpotechno.fi" --header="Referer: http://kartta.arpotechno.fi (antti@myrtillus.net)" -O lahti.osm "http://www.overpass-api.de/api/xapi_meta?*[bbox=     24.98314, 60.87659, 26.28208, 61.37907]"  --header="Referer:http://kartta.arpotechno.fi (antti@myrtillus.net)"

# Split the osm file to smaller pieces

java -jar -Xmx1000m splitter.jar lahti.osm --precomp-sea=sea.zip --geonames-file=cities15000.zip --max-areas=2048 --max-nodes=1000000 --wanted-admin-level=8

# Fix the names in the template.args file descriptions, MAX 20 CHARACTERS

python fix_names.py TK_MTB_Lahti

# Create the gmapsupp map file, NOTE THE MAPNAME HAS TO UNIQUE, FAMILY ID IS ALSO UNIQUE

java -jar -Xmx1000m mkgmap.jar --max-jobs --gmapsupp --latin1 --tdbfile --nsis --mapname=88880003 --family-id=8888 --style-file=TK/ --precomp-sea=sea.zip --generate-sea --route --drive-on=detect,right --process-destination --process-exits --index --bounds=bounds.zip --location-autofill=is_in,nearest --x-split-name-index --housenumbers --remove-ovm-work-files -c template.args TK_Lahti.typ

# copy the map file to /var/www for downloading
mv gmapsupp.img tk_lahti.img
sudo chown www-data:www-data tk_lahti.img
sudo mv -f tk_lahti.img /var/www


sleep 900

# HELSINKI
#################
#################


# Retrieving OSM data directly and generating map
#################################################

# Get the osm datafile

#wget -O helsinki.osm "http://overpass.osm.rambler.ru/cgi/xapi_meta?*[bbox=24.6098, 60.1532, 25.10405, 60.27918]"
sudo wget --user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0" --keep-session-cookies --save-cookies cookies.txt --header="Host: kartta.arpotechno.fi" --header="Referer: http://kartta.arpotechno.fi (antti@myrtillus.net)" -O helsinki.osm "http://www.overpass-api.de/api/xapi_meta?*[bbox=     24.6098, 60.1532, 25.10405, 60.27918]"  --header="Referer:http://kartta.arpotechno.fi (antti@myrtillus.net)"

# Split the osm file to smaller pieces

java -jar -Xmx1000m splitter.jar helsinki.osm --precomp-sea=sea.zip --geonames-file=cities15000.zip --max-areas=2048 --max-nodes=1000000 --wanted-admin-level=8

# Fix the names in the template.args file descriptions, MAX 20 CHARACTERS

python fix_names.py TK_MTB_Helsinki

# Create the gmapsupp map file, NOTE THE MAPNAME HAS TO UNIQUE, FAMILY ID IS ALSO UNIQUE

java -jar -Xmx1000m mkgmap.jar --max-jobs --gmapsupp --latin1 --tdbfile --nsis --mapname=88880003 --family-id=8888 --style-file=TK/ --precomp-sea=sea.zip --generate-sea --route --drive-on=detect,right --process-destination --process-exits --index --bounds=bounds.zip --location-autofill=is_in,nearest --x-split-name-index --housenumbers --remove-ovm-work-files -c template.args TK_Helsinki.typ

# copy the map file to /var/www for downloading
mv gmapsupp.img tk_helsinki.img
sudo chown www-data:www-data tk_helsinki.img
sudo mv -f tk_helsinki.img /var/www


#################################

# Clean the directory
rm -f *.osm osmmap.* *.img *.pbf osmmap_license.txt template* densities* areas*


