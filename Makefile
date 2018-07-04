CURRENTDATE=`date +%Y%m%d`
RASPBIAN_DOCKERFILE=`sed -e 's/debian:jessie/resin\/rpi-raspbian:jessie/' Dockerfile`

all: build

build: pulseaudio

qemu:
	docker run --rm --privileged multiarch/qemu-user-static:register --reset

pulseaudio:
	docker build -t whhoesj/mopidy:pulseaudio .
	docker build -t whhoesj/mopidy:latest .
	docker build -t whhoesj/mopidy:$(CURRENTDATE) .
	echo "$(RASPBIAN_DOCKERFILE)" | docker build -t whhoesj/mopidy:pulseaudio-rpi . -f-
	echo "$(RASPBIAN_DOCKERFILE)" | docker build -t whhoesj/mopidy:latest-rpi . -f-
	echo "$(RASPBIAN_DOCKERFILE)" | docker build -t whhoesj/mopidy:$(CURRENTDATE)-rpi . -f-

push:
	docker push whhoesj/mopidy:pulseaudio
	docker push whhoesj/mopidy:latest
	docker push whhoesj/mopidy:$(CURRENTDATE)
	docker push whhoesj/mopidy:pulseaudio-rpi
	docker push whhoesj/mopidy:latest-rpi
	docker push whhoesj/mopidy:$(CURRENTDATE)-rpi

clean:
	-docker rmi whhoesj/mopidy:pulseaudio
	-docker rmi whhoesj/mopidy:latest
	-docker rmi whhoesj/mopidy:$(CURRENTDATE)
	-docker rmi whhoesj/mopidy:pulseaudio-rpi
	-docker rmi whhoesj/mopidy:latest-rpi
	-docker rmi whhoesj/mopidy:$(CURRENTDATE)-rpi
	rm -rfv test-data/
