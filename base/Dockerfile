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
    && pip install --upgrade pafy

ADD mopidy.conf /var/lib/mopidy/.config/mopidy/mopidy.conf

ADD entrypoint.sh /entrypoint.sh

RUN chown mopidy:audio -R /var/lib/mopidy/.config \
    && chown mopidy:audio /entrypoint.sh

USER mopidy

VOLUME /var/lib/mopidy/local
VOLUME /var/lib/mopidy/media
VOLUME /var/lib/mopidy/.config/mopidy/account-config

EXPOSE 6600
EXPOSE 6680

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/mopidy"]
