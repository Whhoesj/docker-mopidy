CURRENTDATE=`date +%Y%m%d`

all: pulseaudio

pulseaudio:
	docker build -t whhoesj/mopidy:pulseaudio .
	docker build -t whhoesj/mopidy:latest .
	docker build -t whhoesj/mopidy:$(CURRENTDATE) .

push:
	docker push whhoesj/mopidy:pulseaudio
	docker push whhoesj/mopidy:latest
	docker push whhoesj/mopidy:$(CURRENTDATE)

clean:
	-docker rmi whhoesj/mopidy:pulseaudio
	-docker rmi whhoesj/mopidy:latest
	-docker rmi whhoesj/mopidy:$(CURRENTDATE)
	rm -rfv test-data/
