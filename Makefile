all: pulseaudio

pulseaudio:
	docker build -t whhoesj/mopidy:pulseaudio .
	docker build -t whhoesj/mopidy:latest .

push:
	docker push whhoesj/mopidy:pulseaudio
	docker push whhoesj/mopidy:latest

clean:
	-docker rmi whhoesj/mopidy:pulseaudio
	-docker rmi whhoesj/mopidy:latest
	rm -rfv test-data/
