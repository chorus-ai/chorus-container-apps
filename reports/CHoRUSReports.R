#!/usr/bin/Rscript
# Wrapper around CHoRUSReports to generate report output for data generating sites

library(rlang)
library(CHoRUSReports)

inform("Assigning parameters using sys env variables")

# Author details
authors <- Sys.getenv("AUTHORS") # printed on the title page

# Details specific to the database:
databaseId <- Sys.getenv("CDM_SOURCE")
databaseName <- Sys.getenv("CDM_SOURCE")
databaseDescription <-Sys.getenv("CDM_DESCRIPTION")

# For Oracle: define a schema that can be used to emulate temp tables:
oracleTempSchema <- NULL

# Details for connecting to the CDM and storing the results
outputFolder <- file.path("/output", "chorusreports",databaseId)
cdmDatabaseSchema <- Sys.getenv("CDM_SCHEMA")
resultsDatabaseSchema <- Sys.getenv("RESULTS_SCHEMA") # Make sure the Achilles results are in this schema!
vocabDatabaseSchema <- Sys.getenv("CDM_SCHEMA")

dbms <- Sys.getenv("DB_DBMS")
server  <- paste(Sys.getenv("DB_HOSTNAME"), Sys.getenv("DB_NAME"), sep = "/")
user <- Sys.getenv("DB_USERNAME")
password <- Sys.getenv("DB_PASSWORD")
port <- Sys.getenv("DB_PORT")
pathToDriver <- "/opt/jdbc-drivers"

# All results smaller than this value are removed from the results.
smallCellCount <- 1

verboseMode <- TRUE

connectionDetails <- createConnectionDetails(dbms=dbms,
                                             server=server,
                                             user=user,
                                             password=password,
                                             port=port,
                                             pathToDriver = pathToDriver)

results<-CHoRUSReports(
  connectionDetails = connectionDetails,
  cdmDatabaseSchema = cdmDatabaseSchema,
  resultsDatabaseSchema = resultsDatabaseSchema,
  vocabDatabaseSchema = vocabDatabaseSchema,
  oracleTempSchema = oracleTempSchema,
  databaseId = databaseId,
  databaseName = databaseName,
  databaseDescription = databaseDescription,
  runVocabularyChecks = TRUE,
  runDataTablesChecks = TRUE,
  smallCellCount = smallCellCount,
  sqlOnly = FALSE,
  outputFolder = outputFolder,
  verboseMode = verboseMode
)

generateResultsDocument(
  results,
  outputFolder,
  authors=authors,
  databaseId = databaseId,
  databaseName = databaseName,
  databaseDescription = databaseDescription,
  smallCellCount = smallCellCount
)
