#! /bin/bash
docker run \
    --rm \
    --name mopidy \
    -e PULSE_SERVER=tcp:10.10.0.10:4713 \
    -e USE_SNAPCAST=true \
    -v /home/wouter/Muziek/Spotify:/media:ro \
    -v $PWD/test-data:/var/lib/mopidy \
    -v $PWD/accounts.conf:/mopidy.conf \
    -p 6600:6600 \
    -p 6680:6680 \
    -p 6681:6681 \
    -p 1704:1704 \
    -p 1705:1705 \
    whhoesj/mopidy:latest

