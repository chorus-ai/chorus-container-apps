#!/bin/sh

sed -i "s|@DB_USERNAME|${DB_USERNAME}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@DB_PASSWORD|${DB_PASSWORD}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@DB_HOST|${DB_HOST}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@DB_PORT|${DB_PORT}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@DB_NAME|${DB_NAME}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@V4_DB_USERNAME|${V4_DB_USERNAME}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@V4_DB_PASSWORD|${V4_DB_PASSWORD}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@V4_DB_HOST|${V4_DB_HOST}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@V4_DB_PORT|${V4_DB_PORT}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@V4_DB_NAME|${V4_DB_NAME}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@V5_DB_USERNAME|${V5_DB_USERNAME}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@V5_DB_PASSWORD|${V5_DB_PASSWORD}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@V5_DB_HOST|${V5_DB_HOST}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@V5_DB_PORT|${V5_DB_PORT}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@V5_DB_NAME|${V5_DB_NAME}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@SOLR_HOST|${SOLR_HOST}|" /app/BOOT-INF/classes/application.properties
sed -i "s|@SOLR_DATA_NAME|${SOLR_DATA_NAME}|" /app/BOOT-INF/classes/application.properties

/usr/bin/java -classpath .:BOOT-INF/lib:BOOT-INF/lib/*:BOOT-INF/classes -Djava.security.egd=file:///dev/./urandom org.springframework.boot.loader.JarLauncher
