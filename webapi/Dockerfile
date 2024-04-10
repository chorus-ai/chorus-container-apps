FROM busybox AS busybox
ADD https://databricks-bi-artifacts.s3.us-east-2.amazonaws.com/simbaspark-drivers/jdbc/2.6.32/DatabricksJDBC42-2.6.32.1054.zip .
RUN unzip DatabricksJDBC42-*.zip

FROM ohdsi/webapi:2.13.0
COPY --from=busybox /DatabricksJDBC42.jar /var/lib/ohdsi/webapi/WEB-INF/lib
