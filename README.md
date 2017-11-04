# Mopidy Docker image
Image for running [Mopidy](https://www.mopidy.com/) in Docker.
Uses [Pulseaudio](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Network/) or [Snapcast](https://github.com/badaix/snapcast) for audio output.

## Audio output
Because Docker images don't have access to the sound card of the host, Pulseaudio or Snapcast can be used.
Audio can be transfered to Pulseaudio by it's [network functionallity](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Network/). Use the `PULSE_AUDIO` envionment variable to point Mopidy to a server.

Alternativly, Snapcast can be used which has support for multi-room audio. I don't use it myself so it's less tested

## Contents
### Frontend extensions
* [Iris](https://github.com/jaedb/Iris)
* [Mopidy Musicbox Webclient](https://github.com/pimusicbox/mopidy-musicbox-webclient)
* [Mopify](https://github.com/dirkgroenen/mopidy-mopify)
* [Mopidy Party](https://github.com/Lesterpig/mopidy-party)
* [Mopidy Simple webclient](https://github.com/xolox/mopidy-simple-webclient)
* [API explorer](https://github.com/dz0ny/mopidy-api-explorer)
* [Local images](https://github.com/tkem/mopidy-local-images)

### Backend extensions
* Spotify
* Spotify tunigo
* Youtube
* Soundcloud
* Scrobbler
* Tunein
* Local SQLite

## How to use
```bash
docker run \
    --name mopidy \
    -e PULSE_SERVER=tcp:10.10.0.10:4713 \  # Pulseaudio server
    -v $PWD/media:/media:ro \              # Media files
    -v $PWD/data:/var/lib/mopidy \         # Mopidy data and cache
    -v $PWD/mopidy.conf:/mopidyconf \      # Override config (for accounts)
    -p 6600:6600 \                         # Port for MPD
    -p 6680:6680 \                         # Port for the webinterface
    -p 6681:6681 \                         # (Optional) Port for Iris pusher service
    -p 1704:1704 \                         # (Optional) Snapcast streaming port
    -p 1705:1705 \                         # (Optional) Snapcast control port
    whhoesj/mopidy
```

## Volumes
To keep the Mopidy data persistent, `/var/lib/mopidy` should be mounted as a volume. The Mopidy user must have write access to this directory. Set this with `chown -R 105 /path/to/data`.

## Accounts
To add Spotify, Last.FM etc. accounts, use the `/mopidy.conf` file. Example:
```
[spotify]
enabled = true
username =
password =

[scrobbler]
enabled = true
username =
password =

[soundcloud]
enabled = true
auth_token =
```

## Local media
To play local media files, mount `/media`. All meta data will be stored using Mopidy-Local-SQLite. To scan for new media files, run `docker exec -it mopidy localscan`.