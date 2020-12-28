FROM debian:buster
LABEL maintainer="wouter@habets.io"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python3 \
    python3-pip \
    git \
    gstreamer1.0-libav \
    python-crypto \
    python-setuptools

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl gnupg \
    && curl -L https://apt.mopidy.com/mopidy.gpg -o /tmp/mopidy.gpg \
    && curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list \
    && apt-key add /tmp/mopidy.gpg \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        mopidy \
        mopidy-mpd \
        mopidy-local \
        mopidy-scrobbler \
        mopidy-soundcloud \
        mopidy-spotify \
        mopidy-tunein

#RUN curl -L https://bootstrap.pypa.io/get-pip.py | python3 -
RUN python3 -m pip install \
    Mopidy-Iris \
    Mopidy-MusicBox-Webclient \
    Mopidy-YouTube

#ADD snapserver.deb /tmp/snapserver.deb
#RUN apt-get install -y libavahi-client3 libavahi-common3 \
#    && dpkg -i /tmp/snapserver.deb \
#    && apt-get install -f \
#    && rm /tmp/snapserver.deb

ADD mopidy.conf /etc/mopidy.conf

ADD entrypoint.sh /entrypoint.sh

RUN chown mopidy:audio -R /var/lib/mopidy \
    && chown mopidy:audio /entrypoint.sh

ADD localscan /usr/bin/localscan
RUN chmod +x /usr/bin/localscan

VOLUME /var/lib/mopidy

EXPOSE 6600
EXPOSE 6680
EXPOSE 6681

USER mopidy

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/mopidy", "--config", "/etc/mopidy.conf:/mopidy.conf"]

