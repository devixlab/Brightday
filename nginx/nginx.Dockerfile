# ================================
# Run image
# ================================
FROM ubuntu:focal

# Make sure all system packages are up to date, and install only essential packages.
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && apt-get -q install -y \
      ca-certificates \
      tzdata \
# If your app or its dependencies import FoundationNetworking, also install `libcurl4`.
       libcurl4 \
# If your app or its dependencies import FoundationXML, also install `libxml2`.
       libxml2 \
    && rm -r /var/lib/apt/lists/*

FROM nginx

# Install only what is needed
RUN apt-get update && apt-get install -y --no-install-recommends curl \
      && rm -rf /var/lib/apt/lists/*

# Remove default Nginx
RUN rm /usr/share/nginx/html/*

# Copy all of our nginx configurations
COPY ./nginx.conf /etc/nginx/nginx.conf
# COPY ./vapor-bdt.conf /etc/nginx/sites-enabled
COPY ./default.conf /etc/nginx/conf.d/default.conf

# 3.Set env variable where NGINX should look for project files
# ENV $vapor_ROOT /app
# ENV app_ROOT /app
ENV $vapor_app /app

# 4.Set working directory
# WORKDIR $vapor_ROOT
# WORKDIR $app_ROOT
WORKDIR $vapor_app

# 5.Create log directory
RUN mkdir log

# 8.Expose port 80 for public access to your app
EXPOSE 80
# Added this!
EXPOSE 443

# Convenience just in case we want to add more configuration later
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Daemon Off otherwise, Docker will drop when the main process is done making child ones
CMD ["./entrypoint.sh"]
#CMD ["nginx", "-g", "daemon off;"]
