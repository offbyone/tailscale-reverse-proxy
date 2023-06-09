FROM golang:1.20 AS compile-proxy
RUN mkdir /src
COPY go.mod go.sum /src/
COPY *.go /src/
WORKDIR /src
RUN go build -v

FROM debian:bookworm-slim
COPY --from=compile-proxy      \
    /src/tailscale-reverse-proxy \
    /usr/local/bin/tailscale-reverse-proxy

VOLUME /var/lib/tailscale

# Dependencies last, because I don't need them to set the rest up
RUN apt-get update && \
    apt-get -y --no-install-recommends install ca-certificates && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD /usr/local/bin/tailscale-reverse-proxy -state-dir /var/lib/tailscale
