FROM maven:3-jdk-8-slim as builder

# for updates, see: https://github.com/OHDSI/Athena/releases
ARG GIT_REF="refs/tags/v1.13.0"

ARG NONROOT_UID=65532
ARG NONROOT_GID=65532

# OS-level deps
RUN set -x \
  && AG="env DEBIAN_FRONTEND=noninteractive apt-get -yq" \
  && $AG update --no-install-recommends \
  && $AG upgrade \
  && $AG install --no-install-recommends \
    ca-certificates \
    git \
    patch \
    unzip \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# acquire the app code
RUN set -ex \
  && git clone "https://github.com/OHDSI/Athena.git" "/build" \
  && if [ -n "$GIT_REF" ]; then \
    git checkout "${GIT_REF}" \
  ; fi

# build the app

RUN mkdir -p /root/.m2 \
    && mkdir /root/.m2/repository

COPY /settings-docker.xml /root/.m2/settings.xml
COPY /settings-docker.xml /root/.m2/settings-docker.xml
COPY /settings-docker.xml /usr/share/maven/conf/settings.xml

RUN --mount=type=cache,target=/root/.m2 set -x \
  && mvn package install -DskipDocker -DskipTests -DskipITtests -DskipUnitTests --no-transfer-progress \
  && unzip -q -d jar target/athena.jar \
  && cp target/athena.jar /build/jar/athena_save.jar

# (re)start from a minimal base container
FROM amazoncorretto:8
LABEL maintainer="jared.houghtaling@tuftsmedicine.org"

WORKDIR /app

COPY --from=builder /build/jar .

#Copy modified source files to change parameters of Athena web application
COPY application.properties ./BOOT-INF/classes/application.properties
COPY logo_Athena_2.png ./BOOT-INF/classes/public/icons/Header/logo_Athena_2.png
COPY favicon.png ./BOOT-INF/classes/public/favicon.ico
COPY app.1fdfbf6aa293d95998ec.js ./BOOT-INF/classes/public/app.1fdfbf6aa293d95998ec.js
COPY card_icons/*.svg ./BOOT-INF/classes/public/icons/Search/
COPY entrypoint.sh .
RUN chmod 777 entrypoint.sh


ENTRYPOINT ["./entrypoint.sh"]
