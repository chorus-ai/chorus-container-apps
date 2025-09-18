FROM postgis/postgis:16-3.4-alpine

RUN apk add libintl gdal gdal-tools gdal-driver-pg

RUN mkdir /csv && mkdir /app && mkdir /sql
# Get data source and variable source from GaiaDB Repo
RUN wget -O /csv/data_source.csv https://raw.githubusercontent.com/OHDSI/gaiaDB/refs/heads/main/csv/data_source.csv
RUN wget -O /csv/variable_source.csv https://raw.githubusercontent.com/OHDSI/gaiaDB/refs/heads/main/csv/variable_source.csv
# Get GIS/SDoH Vocabulary terms from CVB repo
RUN wget -O /csv/gis_vocabulary_fragment.csv https://raw.githubusercontent.com/TuftsCTSI/CVB/refs/heads/main/GIS/Ontology/vocabulary_delta.csv
RUN wget -O /csv/gis_concept_class_fragment.csv https://raw.githubusercontent.com/TuftsCTSI/CVB/refs/heads/main/GIS/Ontology/concept_class_delta.csv
RUN wget -O /csv/gis_domain_fragment.csv https://raw.githubusercontent.com/TuftsCTSI/CVB/refs/heads/main/GIS/Ontology/domain_delta.csv
RUN wget -O /csv/gis_concept_fragment.csv https://raw.githubusercontent.com/TuftsCTSI/CVB/refs/heads/main/GIS/Ontology/concept_delta.csv
RUN wget -O /csv/gis_relationship_fragment.csv https://raw.githubusercontent.com/TuftsCTSI/CVB/refs/heads/main/GIS/Ontology/relationship_delta.csv
RUN wget -O /csv/gis_concept_relationship_fragment.csv https://raw.githubusercontent.com/TuftsCTSI/CVB/refs/heads/main/GIS/Ontology/concept_relationship_delta.csv
COPY sql/init.sql /docker-entrypoint-initdb.d/init.sql
COPY sql/spatial_join_1pt.sql /sql
COPY sql/spatial_join_2pt.sql /sql
COPY csv/* /csv
COPY produce_external_exposure.sh /app
