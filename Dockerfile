FROM alpine:3.24.0@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4 AS builder

ARG CNI_PLUGINS_VER

RUN apk add --update --no-cache curl \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VER}/cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VER}/cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz.sha256 \
  && sha256sum -c cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz.sha256 \
  && tar xvfpz cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz

FROM alpine:3.24.0@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4

WORKDIR /opt/cni/bin

COPY --from=builder /dhcp .

ENTRYPOINT ["/opt/cni/bin/dhcp", "daemon", "-hostprefix", "/host"]
