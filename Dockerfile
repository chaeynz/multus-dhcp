FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a AS builder

ARG CNI_PLUGINS_VER

RUN apk add --update --no-cache curl \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VER}/cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VER}/cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz.sha256 \
  && sha256sum -c cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz.sha256 \
  && tar xvfpz cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz

FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a

WORKDIR /opt/cni/bin

COPY --from=builder /dhcp .

ENTRYPOINT ["/opt/cni/bin/dhcp", "daemon", "-hostprefix", "/host"]
