# CHoRUSReports-app

Modified version of the chorus-ai/etl image that also contains the
[chorus-ai/CHoRUSReports R package](https://github.com/chorus-ai/CHoRUSReports), and
incorporates the [R script](https://github.com/chorus-ai/CHoRUSReports/blob/main/extras/CodeToRun.R)
used to generate Word documents containing overviews of OMOP CDM events across the various CDM tables.

See the included `docker-compose.example.yml` for the configuration necessary
to deploy the image with docker compose.
