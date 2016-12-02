# Mopidy
Image for running [Mopidy](https://www.mopidy.com/) in Docker.
Supports audio output with Pulseaudio or [Snapcast](https://github.com/badaix/snapcast).

## Tags
`latest` and `snapcast` uses Snapcast for audio output
`pulseaudio` uses Pulseaudio for audio output

## How to use
```bash
    docker run \
        --name mopidy \
        -e PULSE_SERVER=tcp:127.0.0.1:4713 \      # (Optional) Pulseaudio server for sound
        -e USE_SNAPCAST=true \                    # Set true to activate Snapcast (event with the Snapcast image)
        -v $PWD/media:/var/lib/mopidy/media:ro \  # Media files
        -v $PWD/local:/var/lib/mopidy/local \     # Some kind of music storage(?)
        -v $PWD/account-config:/var/lib/mopidy/.config/mopidy/account-config \ # Place here the account configurations (see account-config.conf)
        -p 6600:6600 \  # Port for MPD
        -p 6680:6680 \  # Port for the webinterface
        -p 1704:1704 \  # Port for Snapcast streaming
        -p 1705:1705 \  # Port for Snapcast control
        whhoesj/mopidy
```
