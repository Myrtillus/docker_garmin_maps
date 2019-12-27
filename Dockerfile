# The base image
FROM openjdk:8-alpine

# ubuntu version
#RUN apt-get --yes update

# alpine linux
RUN apk update

#RUN apt-get --yes install python3

RUN apk add --no-cache python3

RUN apk add --no-cache git

COPY Garmin_OSM_TK_maps/ /Garmin_OSM_TK_maps
COPY .git/ /.git

#ENTRYPOINT /Garmin_OSM_TK_maps/generate_map.sh



