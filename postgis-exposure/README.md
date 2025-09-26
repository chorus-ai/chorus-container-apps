# README - Postgis exposure Tool

See office hours video here for a description of the tool and its processes:


## Deploy

You can bring up the postgis database with the following command (executed from this directory):

```bash
docker run \
    --rm \
    # The container is intended to be ephemeral
    --name postgis-chorus \
    --env POSTGRES_PASSWORD="dummy" \
    --env VARIABLES="134,135,136" \ 
    # Expand the list to include more variables of interest
    --env DATA_SOURCES="1234,5150,9999" \ 
    # Expand the list to include more data sources
    -v ./test:/source \ 
    # This will load the test LOCATION and LOCATION_HISTORY tables. Replace with true files in same format
    -d \
    ghcr.io/chorus-ai/chorus-postgis-exposure:main
```

This command will bring up a docker container locally with all dependencies to run the data set retrieval and spatial joining processes.

It will take 10-20 seconds to start depending on your environment. Once started (`docker logs postgis-chorus` shows _database is ready to accept connections_) you can launch the workflow with the following docker command:

```bash
docker exec \
    postgis-chorus \
    /app/produce_external_exposure.sh
```

This command will retrieve the data sources and combine them with your data to produce an external_exposure table (also in the `test` directory). Once this is finished, you can stop and remove the container with the following command:

```bash
docker stop \
    postgis-chorus 
```