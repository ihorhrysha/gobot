# APP := $(shell basename $(shell git remote get-url origin) .git)
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

# Defaults
REGISTRY = docker.io
REPOSITORY = ihorhrysha/gobot
#	linux darwin windows
TARGETOS=linux
#	amd64 arm64
TARGETARCH=amd64

IMAGE_TAG = ${REGISTRY}/${REPOSITORY}:${VERSION}-${TARGETOS}-${TARGETARCH}

version:
	@echo ${VERSION}
	

# local development
format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o gobot -ldflags "-X="github.com/ihorhrysha/gobot/cmd.version=${VERSION}

# compilation for different OS
linux: build

mac:
	make build TARGETOS=darwin TARGETARCH=arm64

windows:
	make build TARGETOS=windows TARGETARCH=amd64

# prepare docker image
image:
	docker build . -t ${IMAGE_TAG}  --build-arg TARGETARCH=${TARGETARCH}

push:
	docker push ${IMAGE_TAG}

clean:
	rm -rf gobot || true
	docker rmi ${IMAGE_TAG} || true

release: image push clean
