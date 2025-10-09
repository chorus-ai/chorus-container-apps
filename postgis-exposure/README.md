# README - Postgis exposure Tool

See office hours video here for a description of the tool and its processes:


## Deploy

You can bring up the postgis database with the following command (executed from the root directory of this repo):

```bash
docker run --rm --name postgis-chorus --env POSTGRES_PASSWORD="dummy" --env VARIABLES="134,135,136" --env DATA_SOURCES="1234,5150,9999" -v ./test:/source -d ghcr.io/chorus-ai/chorus-postgis-exposure:main
```

> Note - if you would like to run the code against all variables, create a comma separated list of the variables, assign it to an env variable, and then replace `"134,135,136"` with that env variable (the same process applies to data sources). See below:

```bash
export VARIABLES="139,140,143,144,169,170,173,174,199,201,221,222,223,224,226,407,408,409,410,411,412,245,243,413,414,415,416,417,418,419,420,421,422,423,424,425,156,244,172,171,132,203,213,220,209,228,236,242,233,154,153,134,133,168,167,148,147,150,149,158,157,146,145,204,214,210,202,200,219,216,211,207,208,205,206,212,215,218,217,247,246,184,183,175,176,198,197,178,177,180,179,188,187,194,193,192,191,185,190,189,196,195,182,181,186,162,161,155,136,135,160,159,166,165,138,137,235,232,227,231,241,229,230,238,234,240,237,239,225,248,152,151,142,141,164,163"
docker run --rm --name postgis-chorus --env POSTGRES_PASSWORD="dummy" --env VARIABLES="$VARIABLES" --env DATA_SOURCES="1234,5150,9999" -v ./test:/source -d ghcr.io/chorus-ai/chorus-postgis-exposure:main
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