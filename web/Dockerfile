FROM whhoesj/mopidy:latest
MAINTAINER Wouter Habets (wouterhabets@gmail.com)

USER root
RUN pip install Mopidy-Mopify \
    && pip install Mopidy-Spotmop \
    && pip install Mopidy-MusicBox-Webclient \
    && pip install Mopidy-API-Explorer
USER mopidy
