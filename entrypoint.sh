#!/bin/bash

echo "Starting container..."
echo "Current user: $(whoami)"
echo "Current user id: $(id -u $(whoami))"
cd ~
echo $PWD
ls -lsa
exec $@
