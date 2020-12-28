#! /bin/bash
docker run \
    --rm \
    --name mopidy \
    -e PULSE_SERVER=tcp:10.10.10.14:4713 \
    -v /home/wouter/Muziek:/media:ro \
    -v $PWD/data:/var/lib/mopidy \
    -v $PWD/accounts.conf:/mopidy.conf \
    -p 6600:6600 \
    -p 6680:6680 \
    -p 6681:6681 \
    whhoesj/mopidy:latest

