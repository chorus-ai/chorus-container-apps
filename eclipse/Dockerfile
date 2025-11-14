#
# eclipse Dockerfile
#
# Based on jlesage/docker-firefox
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
ARG ECLIPSE_VERSION=2024-12

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
        pango \
        pulseaudio \
        udev \
        unzip \
        wget \
        curl \
        file \
        zlib-dev \
        # Add java and bash for Eclipse
        openjdk17 \
        bash \
        # GTK and Eclipse dependencies
        gtk+3.0 \
        libsecret \
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
    APP_ICON_URL=https://www.eclipse.org/eclipse.org-common/themes/solstice/public/images/logo/eclipse-foundation-grey-orange.svg && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /
COPY --from=membarrier /tmp/membarrier_check /usr/bin/

# Install Eclipse IDE
RUN \
    mkdir -p /app && \
    cd /tmp && \
    echo "Downloading Eclipse ${ECLIPSE_VERSION}..." && \
    wget --progress=bar:force -O eclipse.tar.gz "https://download.eclipse.org/technology/epp/downloads/release/${ECLIPSE_VERSION}/R/eclipse-java-${ECLIPSE_VERSION}-R-linux-gtk-x86_64.tar.gz" && \
    echo "Download complete. File size: $(stat -c%s eclipse.tar.gz) bytes" && \
    echo "Verifying download is a valid gzip file..." && \
    file eclipse.tar.gz && \
    echo "Extracting Eclipse to /app..." && \
    tar -xzf eclipse.tar.gz -C /app && \
    echo "Contents of /app after extraction:" && \
    ls -la /app/ && \
    rm eclipse.tar.gz && \
    echo "Verifying Eclipse directory exists..." && \
    test -d /app/eclipse || (echo "ERROR: /app/eclipse directory not found!" && ls -la /app && exit 1) && \
    echo "Eclipse extracted. Checking binary..." && \
    ls -la /app/eclipse/eclipse && \
    chmod +x /app/eclipse/eclipse && \
    file /app/eclipse/eclipse && \
    mkdir -p /export/configs/eclipse-workspace && \
    chmod -R 777 /export/configs/eclipse-workspace

# Set internal environment variables.
RUN \
    set-cont-env APP_NAME "Eclipse" && \
    set-cont-env APP_VERSION "$ECLIPSE_VERSION" && \
    set-cont-env DOCKER_IMAGE_VERSION "$DOCKER_IMAGE_VERSION" && \
    true

# Metadata.
LABEL \
      org.label-schema.name="eclipse" \
      org.label-schema.description="Docker container for Eclipse IDE" \
      org.label-schema.version="${DOCKER_IMAGE_VERSION:-unknown}" \
      org.label-schema.vcs-url="https://github.com/chorus-ai/chorus-container-apps" \
      org.label-schema.schema-version="1.0"
