GO := GO111MODULE=on go
DOCKER := DOCKER_DEFAULT_PLATFORM=linux/amd64

.PHONY: ci
ci:
	$(GO) mod tidy && \
	$(GO) mod download && \
	$(GO) mod verify && \
	$(GO) mod vendor && \
	$(GO) fmt ./... \

.PHONY: build
build:
	$(GO) build -mod=vendor -a -installsuffix cgo -tags musl -o main ./main.go

start:
	go run --tags dynamic $(shell pwd)/main.go

dev: 
	nodemon --exec go run --tags dynamic $(shell pwd)/main.go --signal SIGTERM

.PHONY: clean
clean:
	@rm -rf main ./vendor