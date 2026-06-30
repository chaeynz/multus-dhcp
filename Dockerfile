FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS builder

ARG CNI_PLUGINS_VER

RUN apk add --update --no-cache curl \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VER}/cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VER}/cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz.sha256 \
  && sha256sum -c cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz.sha256 \
  && tar xvfpz cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz

FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

WORKDIR /opt/cni/bin

COPY --from=builder /dhcp .

ENTRYPOINT ["/opt/cni/bin/dhcp", "daemon", "-hostprefix", "/host"]
