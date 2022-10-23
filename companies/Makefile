.PHONY: build

GO=go
GO111MODULE := auto
export GO111MODULE
MOD := -mod=vendor

all: build

build: test
	CGO_ENABLED=0 $(GO) build -ldflags="-X 'main.Version=$(VERSION)'" $(MOD) -o companies companies/src/cmd/daemon

buildstatic:
	$(GO) build -tags musl -ldflags="-w -extldflags '-static' -X 'main.Version=$(VERSION)'" $(MOD) -o companies companies/src/cmd/daemon

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

swagger-all: swagger swagger-html

lint:
	golangci-lint run -E gocritic

check-migrate:
	which migrate || (go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest)

migrate: check-migrate
	migrate -database postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}?sslmode=disable -path migrations up

migrate-down: check-migrate
	migrate -database postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}?sslmode=disable -path migrations down $(V)
