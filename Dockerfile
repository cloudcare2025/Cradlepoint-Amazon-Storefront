FROM nginx:stable-alpine

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy static site files
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/
COPY *.html /usr/share/nginx/html/
COPY logos/ /usr/share/nginx/html/logos/

# Copy nginx config as template (Railway injects $PORT at runtime via envsubst)
COPY nginx.conf /etc/nginx/templates/default.conf.template

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:${PORT:-80}/ || exit 1

ENV PORT=80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
