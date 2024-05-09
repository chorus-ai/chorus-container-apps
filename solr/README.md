# OHDSI Broadsea-Solr [In development]

A Docker container for launching an Apache Solr instance with an initialized OMOP Vocabulary core, and optionally run the dataimport step.

## Introduction

Apache Solr can offer significant OMOP Vocabulary search performance improvements in Atlas compared to using a traditional JDBC connection. This repository offers a Docker-based approach for standing up a Solr server. The necessary Vocab core configuration files are added to the standard Solr image and configured with your environment variables.

You can then point your Atlas instance to this Solr core (e.g. `solr.endpoint=http://solr:8983/solr`).

## Initial Setup

1. The name of the Solr core used **must** match the vocabulary version you plan to use in ATLAS & WebAPI with an underscore. For this example, the vocabulary version is "v5.0 31-OCT-22" and we will name the core "v5.0_31-OCT-22". You should verify your vocabulary by running the following query on the CDM(s) you plan to use with WebAPI:

```sql
select replace(vocabulary_version, '_', '') as vocab_version from vocabulary where vocabulary_id = 'None';
```
If your vocabulary version and core do not match, WebAPI will not find the Solr core and it will continue to use the DB when querying the vocabulary.

2. Clone this repo to your server/laptop.
3. Copy the JDBC driver file needed to connect to your OMOP Vocabulary schema to the directory.
4. Save the `.env-sample` file as `.env` and replace the environment variables with the appropriate values for your OMOP Vocabulary setup.

## Starting Broadsea-Solr

There are two methods to starting Broadsea-Solr:

1. **Without auto-starting the dataimport (meaning, you will run that step at a later time in the Solr admin console)**
  - Within the cloned directory, run
    ```bash
    docker-compose up -d
    ```
  - Once ready to run the dataimport, go to the SOLR Admin screen (`http://localhost:8983/solr/#/`), and build the core by using the 'Core Selector' dropdown in the left-hand menu.
    - Select the `v5.0_31-OCT-22` core from the drop down, and then in the sub-menu that appears, select `Dataimport` from the left navigation
    - Select 'full-import' from the Command dropdown, check the 'Commit' box, and select 'concept' from the Entity dropdown.
    - Enter `vocab_database_schema=<your vocab schema name>` in the Custom Parameters field.
    - Hit the 'Execute' button.
    - Once the execution of the core indexing is complete, you can use the Solr "Query" tool under the core sub-menu to make sure the core is working properly before moving to WebAPI. A sample query you can use is: `query:metformin`

2. **With dataimport auto-started (recommended)**
  - Within the cloned directory, run
    ```bash
    docker-compose --profile dataimport up -d
    ```
  - The dataimport container will wait until the vocab-core container is finished starting, and then kick off the dataimport process.
  - The dataimport process can take as long as 20 minutes, but you can monitor the progress within the Solr admin console.

See https://github.com/OHDSI/Broadsea for more information on Docker, Docker Compose, and Broadsea in general.
