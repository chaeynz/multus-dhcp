FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf AS builder

ARG CNI_PLUGINS_VER

RUN apk add --update --no-cache curl \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VER}/cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VER}/cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz.sha256 \
  && sha256sum -c cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz.sha256 \
  && tar xvfpz cni-plugins-linux-amd64-${CNI_PLUGINS_VER}.tgz

FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

WORKDIR /opt/cni/bin

COPY --from=builder /dhcp .

ENTRYPOINT ["/opt/cni/bin/dhcp", "daemon", "-hostprefix", "/host"]
