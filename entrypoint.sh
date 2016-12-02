#!/bin/bash

if [ "$USE_SNAPCAST" = true ] ; then
    snapserver -d
fi

exec /usr/bin/mopidy --config /var/lib/mopidy/.config/mopidy/mopidy.conf:/var/lib/mopidy/.config/mopidy/account-config/accounts.conf:/var/lib/mopidy/.config/mopidy/account-config/audio.conf
