.PHONY: build clean

all: clean build

build:
	mkdir -p dist/
	dpkg-deb --build proxy-configurator dist

clean:
	rm -rf dist/