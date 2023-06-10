FROM debian:bookworm-slim AS setup
ARG EXECUTABLE=tailscale-reverse-proxy
RUN mkdir -p /tmp/ts-r-p/
COPY ${EXECUTABLE} /tmp/ts-r-p/
RUN mv -v /tmp/ts-r-p/* /tmp/tailscale-reverse-proxy
RUN chmod +x /tmp/tailscale-reverse-proxy

FROM debian:bookworm-slim
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y --no-install-recommends install ca-certificates && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=setup /tmp/tailscale-reverse-proxy /usr/local/bin/

VOLUME /var/lib/tailscale

CMD /usr/local/bin/tailscale-reverse-proxy -state-dir /var/lib/tailscale
