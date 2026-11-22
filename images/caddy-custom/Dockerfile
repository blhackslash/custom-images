# Keep both stages on the same Caddy minor so the plugins are built against
# the same Caddy version the runtime image ships. The weekly rebuild still
# picks up patch releases (2.11.x); bump the minor here deliberately.
ARG CADDY_VERSION=2.11

FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-l4 \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/fvbommel/caddy-combine-ip-ranges

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Fail the build if a plugin silently went missing.
RUN caddy list-modules > /tmp/modules \
 && grep -qx 'dns.providers.cloudflare' /tmp/modules \
 && grep -qx 'layer4' /tmp/modules \
 && grep -qx 'http.ip_sources.cloudflare' /tmp/modules \
 && grep -qx 'http.ip_sources.combine' /tmp/modules \
 && rm /tmp/modules
