# ============================================================================
#  KIA / Urbex dashboard — production image
#  A single self-contained index.html served by nginx.
#  DigitalOcean App Platform builds this image and runs it as a Service.
# ============================================================================
FROM nginx:1.27-alpine

# Custom server config: listens on 8080 (App Platform's http_port),
# gzip on, sane cache headers, fallback to index.html.
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Ship only the static payload (the encrypted, self-contained dashboard).
COPY index.html /usr/share/nginx/html/index.html

# Must match `http_port` in .do/app.yaml.
EXPOSE 8080

# The base image already runs:  nginx -g 'daemon off;'
# A simple in-container health probe (App Platform also probes over HTTP).
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1:8080/ || exit 1
