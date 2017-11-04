FROM debian:jessie
MAINTAINER Wouter Habets (wouterhabets@gmail.com)

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
    && curl -L https://apt.mopidy.com/mopidy.gpg -o /tmp/mopidy.gpg \
    && curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list \
    && apt-key add /tmp/mopidy.gpg \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        mopidy \
        mopidy-scrobbler \
        mopidy-soundcloud \
        mopidy-spotify \
        mopidy-spotify-tunigo \
        mopidy-tunein \
        git \
        gstreamer0.10-plugins-bad \
        gstreamer0.10-alsa \
        gstreamer1.0-libav \
        python-crypto \
        python-setuptools

RUN curl -L https://bootstrap.pypa.io/get-pip.py | python -
RUN pip install -U six \
    && pip install markerlib \
    && pip install Mopidy-YouTube \
    && pip install Mopidy-Local-SQLite \
    && pip install Mopidy-Local-Images \
    && pip install Mopidy-Party \
    && pip install Mopidy-Simple-Webclient \
    && pip install Mopidy-Iris \
    && pip install Mopidy-MusicBox-Webclient \
    && pip install Mopidy-API-Explorer \
    && pip install Mopidy-Mopify

ADD snapserver_0.12.0_amd64.deb /tmp/snapserver.deb
RUN apt-get install -y libavahi-client3 libavahi-common3 \
   && dpkg -i /tmp/snapserver.deb \
   && apt-get install -f \
   && rm /tmp/snapserver.deb

RUN mkdir /var/lib/snapserver \
    && chown mopidy:audio -R /var/lib/snapserver \
    && mkdir /var/run/snapserver \
    && chown mopidy:audio -R /var/run/snapserver

ADD mopidy.conf /etc/mopidy.conf
ADD audio-pulse.conf /audio-pulse.conf
ADD audio-snapcast.conf /audio-snapcast.conf

ADD entrypoint.sh /entrypoint.sh

RUN chown mopidy:audio -R /var/lib/mopidy \
    && chown mopidy:audio /entrypoint.sh

ADD localscan /usr/bin/localscan
RUN chmod +x /usr/bin/localscan

VOLUME /var/lib/mopidy
VOLUME /media
VOLUME /mopidy.conf

EXPOSE 6600
EXPOSE 6680
EXPOSE 6681
EXPOSE 1704
EXPOSE 1705

USER mopidy

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/mopidy"]
