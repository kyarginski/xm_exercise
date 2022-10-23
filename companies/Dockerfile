# Build Phase
FROM golang:alpine AS builder

ARG VERSION=0.0.0
ENV VERSION=$VERSION

RUN apk update && apk add gcc make librdkafka-dev openssl-libs-static zlib-static zstd-libs libsasl librdkafka-static lz4-dev lz4-static zstd-static libc-dev musl-dev git

WORKDIR /app
COPY . /app
ENV GO111MODULE=on
RUN make buildstatic
# RUN make build

# Execution Phase
FROM alpine:latest

RUN apk --no-cache add ca-certificates \
	&& addgroup -S app \
	&& adduser -S app -G app

# for migrations
# RUN go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest

WORKDIR /app
COPY --from=builder /app/migrations ./migrations
COPY --from=builder /app/doc ./doc
COPY --from=builder /app/Makefile ./
COPY --from=builder /app .
RUN chmod -R 777 /app
USER app

# Expose port 8405 to the outside world
EXPOSE 8405

# Command to run the executable
CMD ["./companies"]
