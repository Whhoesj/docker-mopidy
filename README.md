Mopidy
======
Image for running Mopidy in Docker.
Based on [wernight/docker-mopidy](https://github.com/wernight/docker-mopidy).

## How to use
```bash
    docker run \
        --name mopidy \
        -e PULSE_SERVER=tcp:127.0.0.1:4713 \      # Pulseaudio server for sound
        -v $PWD/media:/var/lib/mopidy/media:ro \  # Media files
        -v $PWD/local:/var/lib/mopidy/local \ # Some kind of music storage(?)
        -v $PWD/account-config:/var/lib/mopidy/.config/mopidy/account-config \ # Place here the account configurations (see account-config.conf)
        -p 6600:6600 \  # Port for MPD
        -p 6680:6680 \  # Port for the webinterface
        whhoesj/mopidy-web
```