FROM alpine:3.23.4
RUN apk add --update \
	curl \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/v1.9.1/cni-plugins-linux-amd64-v1.9.1.tgz \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/v1.9.1/cni-plugins-linux-amd64-v1.9.1.tgz.sha256 \
  && sha256sum -c cni-plugins-linux-amd64-v1.9.1.tgz.sha256 \
  && tar xvfpz cni-plugins-linux-amd64-v1.9.1.tgz

ENTRYPOINT ["./dhcp", "daemon", "-hostprefix", "/host"]
