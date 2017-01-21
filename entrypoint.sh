#!/bin/bash

echo $PWD
cd ~
echo $PWD
ls -lsa
exec /usr/bin/mopidy --config /etc/mopidy.conf:/mopidy.conf
