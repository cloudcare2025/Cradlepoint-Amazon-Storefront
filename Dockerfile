FROM nginx:stable-alpine

RUN rm /etc/nginx/conf.d/default.conf

COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/
COPY *.html /usr/share/nginx/html/
COPY logos/ /usr/share/nginx/html/logos/

COPY nginx.conf /etc/nginx/templates/default.conf.template

# Only substitute $PORT, leave nginx variables ($uri etc.) untouched
ENV NGINX_ENVSUBST_FILTER=PORT

CMD ["nginx", "-g", "daemon off;"]
