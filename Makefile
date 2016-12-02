all: snapcast pulseaudio

snapcast:
	cp audio-snapcast.conf audio.conf
	docker build -t whhoesj/mopidy:snapcast .

pulseaudio:
	cp audio-pulseaudio.conf audio.conf
	docker build -t whhoesj/mopidy:pulseaudio .
	docker build -t whhoesj/mopidy:latest .

push:
	docker push whhoesj/mopidy:snapcast
	docker push whhoesj/mopidy:pulseaudio
	docker push whhoesj/mopidy:latest

clean:
	-rm -rfv audio.conf
	-docker rmi whhoesj/mopidy:snapcast
	-docker rmi whhoesj/mopidy:pulseaudio
	-docker rmi whhoesj/mopidy:latest