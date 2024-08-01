APP := $(shell basename $(shell git remote get-url origin) .git)
GIT_TAG = $(shell git describe --tags --abbrev=0)
GIT_REVISION = $(shell git rev-parse --short HEAD)
VERSION = $(if $(GIT_TAG),$(GIT_TAG),$(GIT_REVISION))

# Defaults
REGISTRY = ihorhrysha
TARGETOS=linux #linux darwin windows
TARGETARCH=amd64 #amd64 arm64

TAG = ${VERSION}-${TARGETARCH}
IMAGE_TAG = ${REGISTRY}/${APP}:${TAG}

e:
	@echo ${IMAGE_TAG}
	@echo ${APP}
	@echo ${VERSION}
	@echo ${GIT_TAG}
	@echo ${GIT_REVISION}
	@echo ${REGISTRY}

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
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o gobot -ldflags "-X="github.com/ihorhrysha/gobot/cmd.appVersion=${VERSION}

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

release: e image push clean
