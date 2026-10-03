FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 AS builder

ARG CNI_PLUGINS_VER

RUN apk add --update --no-cache curl \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VER}/cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VER}/cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz.sha256 \
  && sha256sum -c cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz.sha256 \
  && tar xvfpz cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz

FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

WORKDIR /opt/cni/bin

COPY --from=builder /dhcp .

ENTRYPOINT ["/opt/cni/bin/dhcp", "daemon", "-hostprefix", "/host"]
