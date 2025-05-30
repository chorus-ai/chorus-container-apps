#
# firefox Dockerfile
#
# https://github.com/jlesage/docker-firefox
#

# Build the membarrier check tool.
FROM alpine:3.14 AS membarrier
WORKDIR /tmp
COPY membarrier_check.c .
RUN apk --no-cache add build-base linux-headers
RUN gcc -static -o membarrier_check membarrier_check.c
RUN strip membarrier_check

# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.21-v4.7.1

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=

# Define software versions.
ARG CHROMIUM_VERSION=134.0.6998.88-r1
#ARG PROFILE_CLEANER_VERSION=2.36

# Define software download URLs.
#ARG PROFILE_CLEANER_URL=https://github.com/graysky2/profile-cleaner/raw/v${PROFILE_CLEANER_VERSION}/common/profile-cleaner.in

# Define working directory.
WORKDIR /tmp


# Install extra packages.
RUN \
    add-pkg \
        alsa-plugins-pulse \
        alsa-utils \
        dbus-x11 \
        ffmpeg-libs \
        icu-libs \
        iso-codes \
        libcanberra-gtk3 \
        libexif \
        linux-firmware-i915 \
        mesa-dri-gallium \
        mesa-gl \
        mesa-va-gallium \
        # # swrast available since v3.17
        # mesa-vulkan-swrast \
        pango \
        pulseaudio \
        udev \
        unzip \
        zlib-dev \
        # Add java and bash for SQL Workbench
        openjdk11 \
        bash \
        # WebGL support.
        mesa-dri-gallium \
        # Audio support.
        libpulse \
        # Icons used by folder/file selection window (when saving as).
        adwaita-icon-theme \
        # A font is needed.
        font-dejavu \
        # The following package is used to send key presses to the X process.
        xdotool \
        && \
    # Remove unneeded icons.
    find /usr/share/icons/Adwaita -type d -mindepth 1 -maxdepth 1 -not -name 16x16 -not -name scalable -exec rm -rf {} ';' && \
    true


# Generate and install favicons.
RUN \
    APP_ICON_URL=https://pbs.twimg.com/media/D7XKFpaWwAEGPaF.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /
COPY --from=membarrier /tmp/membarrier_check /usr/bin/

#Install SQL Workbench
RUN \
    mkdir /app && mkdir /app/sql-workbench && \
    wget https://www.sql-workbench.eu/Workbench-Build132-with-optional-libs.zip && \
    unzip Workbench-Build132-with-optional-libs.zip -d /app/sql-workbench && \
    chmod +x /app/sql-workbench/sqlworkbench.sh && \
    mkdir -p /export/configs/SQLWorkbench && \
    chmod -R 777 /export/configs/SQLWorkbench


# Set internal environment variables.
RUN \
    set-cont-env APP_NAME "SQL-Workbench" && \
    set-cont-env APP_VERSION "$FIREFOX_VERSION" && \
    set-cont-env DOCKER_IMAGE_VERSION "$DOCKER_IMAGE_VERSION" && \
    true


# Metadata.
LABEL \
      org.label-schema.name="sql workbench" \
      org.label-schema.description="Docker container for SQL Woprkbench" \
      org.label-schema.version="${DOCKER_IMAGE_VERSION:-unknown}" \
      org.label-schema.vcs-url="https://github.com/jlesage/docker-firefox" \
      org.label-schema.schema-version="1.0"
