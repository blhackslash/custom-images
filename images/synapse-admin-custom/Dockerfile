# Synapse Admin with nginx moved from port 80 to 8081.
FROM awesometechnologies/synapse-admin:0.11.4

# Fail the build if upstream changes the config and the sed stops matching,
# instead of silently shipping an image that still listens on 80.
RUN sed -i 's/listen[[:space:]]*80;/listen 8081;/g' /etc/nginx/conf.d/default.conf \
 && grep -q 'listen 8081;' /etc/nginx/conf.d/default.conf

EXPOSE 8081
