.PHONY: build

GO=go
GO111MODULE := auto
export GO111MODULE
MOD := -mod=vendor

all: build

build: test
	$(GO) build -mod vendor -ldflags="-w -s" -o admin admin/src/cmd/daemon

buildstatic:
	$(GO) build -tags musl -ldflags="-w -extldflags '-static' -X 'main.Version=$(VERSION)'" $(MOD) -o admin admin/src/cmd/daemon

test:
	$(GO) test -count=1 -race ./...

check-swagger:
	which swagger || (GO111MODULE=off go get -u github.com/go-swagger/go-swagger/cmd/swagger)

swagger: check-swagger
	GO111MODULE=on go mod vendor && GO111MODULE=off swagger generate spec -o ./doc/swagger.json --scan-models

serve-swagger: check-swagger
	swagger serve -F=swagger ./doc/swagger.json

swagger-html:
	redoc-cli bundle -o ./doc/api.html ./doc/swagger.json

check-mdtohtml:
	which mdtohtml || (GO111MODULE=off go get -u github.com/gomarkdown/mdtohtml)

mdtohtml: check-mdtohtml
	mdtohtml README.md ./doc/index.html

api-doc: swagger mdtohtml swagger-html

lint:
	golangci-lint run -E gocritic
