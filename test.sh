#! /bin/bash
docker run \
    --rm \
    --name mopidy \
    -e PULSE_SERVER=tcp:10.10.0.1:4713 \
    -v /home/wouter/Muziek/Spotify:/media:ro \
    -v $PWD/test-data:/var/lib/mopidy \
    -v $PWD/accounts.conf:/mopidy.conf \
    -p 6600:6600 \
    -p 6680:6680 \
    -p 6681:6681 \
    whhoesj/mopidy:latest

