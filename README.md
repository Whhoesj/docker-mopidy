# Mopidy Docker image
Image for running [Mopidy](https://www.mopidy.com/) in Docker.  
Uses Pulseaudio for audio output.

## Contents
### Frontend extensions
* [Iris](https://github.com/jaedb/Iris)
* [Mopidy Musicbox Webclient](https://github.com/pimusicbox/mopidy-musicbox-webclient)

### Backend extensions
* Spotify
* Soundcloud
* Scrobbler
* Tunein

## How to use
```bash
docker run \
    --name mopidy \
    -e PULSE_SERVER=tcp:0.0.0.0:4713 \     # Pulseaudio server. Point to external IP of Pulse server
    -v $PWD/media:/media:ro \              # Media files
    -v $PWD/data:/var/lib/mopidy \         # Mopidy data and cache
    -v $PWD/mopidy.conf:/mopidy.conf \     # Override config (for accounts)
    -p 6600:6600 \                         # Port for MPD
    -p 6680:6680 \                         # Port for the webinterface
    -p 6681:6681 \                         # (Optional) Port for Iris pusher service
    whhoesj/mopidy
```

## Sound
To get sound, run a Pulseaudio server with tcp enabled. Point the `PULSE_SERVER` environment variable in the container to the external IP of the machine running the Pulseaudio server.

## Volumes
To keep the Mopidy data persistent, `/var/lib/mopidy` should be mounted as a volume. The Mopidy user must have write access to this directory. Set this with `chown -R 105 /path/to/data`.

## Configuration
To add Spotify, Last.FM etc. accounts, use the `/mopidy.conf` file. Example:
```
[spotify]
enabled = true
username =
password =
client_id = 
client_secret =
# To authenticate go to:
# https://mopidy.com/ext/spotify/#authentication

[scrobbler]
enabled = true
username =
password =

[soundcloud]
enabled = true
auth_token =
```

This same file can be used to override parts of the default configuration. For example: by default, the file browser in Mopidy is disabled to enable it:
```
[file]
enable = true
```
The complete default config can be found in the file [mopidy.conf](./mopidy.conf)

## Local media
To play local media files, mount `/media`. To scan for new media files, run `docker exec -it mopidy localscan`.

## Adding extensions
To add extensions, I advice to override this image by creating your own Dockerfile.
In the example below, a package is installed with pip. To add packages, we switch to the root user, run `pip` to add everything we need and switch back to the `mopidy` user.
```Dockerfile
FROM whhoesj/mopidy:latest
USER root
RUN python3 -m pip install <your-package>
USER mopidy
```
