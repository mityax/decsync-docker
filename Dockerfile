#!/usr/bin/env -S docker build . --tag=decsync-caldav --file

#
# To run the container, use:
# 
# docker run -p 5232:5232 --restart unless-stopped --name decsync-caldav -v <decsync-data-directory>:/decsync-data -it decsync-caldav
#


FROM tomsquest/docker-radicale

# Install dependencies:
RUN apk add --no-cache libstdc++ libc6-compat


# Install the decsync plugin:
RUN python3 -m pip install --break-system-packages git+https://github.com/mab122/Radicale-DecSync.git@fix/storage_discovery_arguments_mismatch

# TODO: revert the above command to the following, once https://github.com/39aldo39/Radicale-DecSync/pull/34
# has been merged:
#
# RUN python3 -m pip install --break-system-packages radicale_storage_decsync


# Create the directory to synchronize:
RUN mkdir /decsync-data

# Add the decsync plugin configuration:
RUN echo $' \n\
[storage] \n\
type = radicale_storage_decsync \n\
# filesystem_folder = ~/.var/lib/radicale/collections \n\
decsync_dir = /decsync-data \n' >> /config/decsync-config

ENV RADICALE_CONFIG="/config/config:/config/decsync-config"
ENV TAKE_FILE_OWNERSHIP="false"

# The original CMD includes a hardcoded "--config <...>" argument, which makes it ignore the
# environment variable ("RADICALE_CONFIG"). Thus, we override the CMD:
CMD ["radicale"]

