# syntax=docker/dockerfile:1

FROM scratch

LABEL maintainer="seanD111"

# copy local files
COPY root/ /
