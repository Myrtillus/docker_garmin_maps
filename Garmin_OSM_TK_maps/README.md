Lataa mkgmaps osoitteesta:
http://www.mkgmap.org.uk/download/mkgmap.html

Pura paketti, siirra mkgmap.jar ja lib/ hakemisto paatasolle

Lataa zippi fileet bounds.zip ja  sea.zip osoittesta:
http://www.mkgmap.org.uk/download/mkgmap.html
ja file cities.zip
download.geonames.org/export/dump/cities15000.zip  

jata paketit paatasolle

Lataa osmosis paketti osoitteesta:
http://bretth.dev.openstreetmap.org/osmosis-build/osmosis-latest.zip

tee hakemisto osmosis ja pura paketti sinne (ala paatasolle)



Manuaalisesti kartan generointi:

Uusimman Suomi dumpin splittaus:
********************************
osmosis/bin/osmosis --read-pbf file=/var/tmp/osm/finland-latest.osm.pbf --bounding-box left=23.20 bottom=61.20 right=24.6 top=62.00 --write-pbf tampere_region_final.osm.pbf


Kartan generointi:
******************
java -jar -Xmx1000m mkgmap.jar --max-jobs --gmapsupp --latin1 --tdbfile --nsis --mapname=88889999 --description=OSM_MTB_Tampere_region --family-id=8888 --series-name="OSM MTB Tampere region" --style-file=TK/ --precomp-sea=sea.zip --generate-sea --route --drive-on=detect,right --process-destination --process-exits --index --bounds=bounds.zip --location-autofill=is_in,nearest --x-split-name-index --housenumbers --remove-ovm-work-files tampere_region_final.osm.pbf TK.typ


Siivoilua operaatioiden jalkeen
*******************************

rm osmmap.* *.img *.pbf osmmap_license.txt
