#!/bin/bash

if [ "$USE_SNAPCAST" = true ] ; then
    echo "Starting Mopidy and Snapcast"
    snapserver -d
    exec /usr/bin/mopidy --config /etc/mopidy.conf:/mopidy.conf:/audio-snapcast.conf
else
    echo "Starting Mopidy with Pulseaudio output"
    exec /usr/bin/mopidy --config /etc/mopidy.conf:/mopidy.conf:/audio-pulse.conf
fi

