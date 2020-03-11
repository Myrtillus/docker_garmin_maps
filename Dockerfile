# alpine linux
#FROM openjdk:8-alpine
#RUN apk update
#RUN apk add --no-cache python3
#RUN apk add --no-cache git


# Ubuntu version
FROM ubuntu:18.04
RUN apt-get --yes update
RUN apt-get install --yes apt-utils openjdk-8-jdk python3 osmosis 
RUN apt-get install --yes wget

#RUN apt-get install --yes openjdk-8-jdk
#RUN apt-get install --yes python3
#RUN apt-get install --yes osmosis 	

COPY Garmin_OSM_TK_maps/ /Garmin_OSM_TK_maps
COPY .git/ /.git

#ENTRYPOINT /Garmin_OSM_TK_maps/generate_map.sh



