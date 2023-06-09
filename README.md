# Tailscale Reverse Proxy

What it says on the tin; this is a variation / fork of the grafana reverse proxy
that Xe Iaso wrote [here](https://github.com/tailscale/tailscale/tree/main/cmd/proxy-to-grafana)

## Usage

On the command line, the `-help` will cover you:

```shellsession
$ ./tailscale-reverse-proxy -help
Usage of ./tailscale-reverse-proxy:
  -add-tailscale-user
    	Add tailscale authentication
  -backend-addr string
    	Address of the Grafana server served over HTTP, in host:port format. Typically localhost:nnnn.
  -hostname string
    	Tailscale hostname to serve on, used as the base name for MagicDNS or subdomain in your domain alias for HTTPS.
  -state-dir string
    	Alternate directory to use for Tailscale state storage. If empty, a default is used. (default "./")
  -use-https
    	Serve over HTTPS via your *.ts.net subdomain if enabled in Tailscale admin.
```

All of this does what you think .

If you want, this is also provided as a Docker image:

```shellsession
$ docker volume create tailscale-data
$ docker run --rm -it ghcr.io/offbyone/tailscale-reverse-proxy:edge \
    -v tailscale-data:/var/lib/tailscale \
    --env-file ./file-with-TS_AUTH_KEY-in-it \
    /usr/local/bin/tailscale-reverse-proxy \
    -state-dir=/var/lib/tailscale \
    -hostname=your-proxy-host \
    -backend-addr=local-service-reachable-from-the-container:8080
```

To make this work you'll want a credential file with `TS_AUTH_KEY` set.
