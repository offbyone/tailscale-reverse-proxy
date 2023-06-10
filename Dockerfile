FROM debian:bookworm-slim
ARG EXECUTABLE=tailscale-reverse-proxy

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y --no-install-recommends install ca-certificates && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ${EXECUTABLE} /usr/local/bin/tailscale-reverse-proxy

VOLUME /var/lib/tailscale

CMD /usr/local/bin/tailscale-reverse-proxy -state-dir /var/lib/tailscale
