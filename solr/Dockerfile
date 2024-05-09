FROM curlimages/curl AS BUILDER
RUN curl -O https://jdbc.postgresql.org/download/postgresql-42.4.2.jar

FROM solr:8.11.3
COPY --from=BUILDER /home/curl_user/postgresql-42.4.2.jar /opt/solr-8.11.1/server/lib/postgresql-42.4.2.jar
COPY ./solr /tmp/solr_config
COPY solr.in.sh /etc/default/solr.in.sh