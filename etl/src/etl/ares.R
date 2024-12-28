args <- commandArgs(TRUE)
if (length(args) != 3) {
    stop(sprintf("Usage: %s <dataroot> %s <dbmode> %s <schema>",
    commandArgs()[1],
    commandArgs()[2],
    commandArgs()[3]))
}
aresDataRoot <- args[1];
dbmode <- args[2]

connectionDetails <- DatabaseConnector::createConnectionDetails(
    dbms = 'postgresql',
    server = paste('/', dbmode),
    connectionString = sprintf(
        'jdbc:postgresql://%s:%s/%s',
        Sys.getenv('PGHOST'),
        Sys.getenv('PGPORT', unset = '5432'),
        dbmode
    ),
    user = Sys.getenv('PGUSER'),
    password = Sys.getenv('PGPASSWORD')
)
cdmVersion <- '5.4'
cdmDatabaseSchema <- args[3]
createIndices <- F
numThreads <- 1
numThreadsDQD <- 1
cdmSourceName <- dbmode


Achilles::achilles(
    cdmVersion = cdmVersion,
    connectionDetails = connectionDetails,
    cdmDatabaseSchema = cdmDatabaseSchema,
    createIndices = createIndices,
    numThreads = numThreads,
    excludeAnalysisIds =  c(717, 815, 1815) # Exclude inefficient analyses for now https://github.com/OHDSI/Achilles/issues/717
)

releaseKey <- AresIndexer::getSourceReleaseKey(connectionDetails, cdmDatabaseSchema)
datasourceReleaseOutputFolder <- file.path(aresDataRoot, releaseKey)

DataQualityDashboard::executeDqChecks(
    connectionDetails = connectionDetails,
    cdmDatabaseSchema = cdmDatabaseSchema,
    resultsDatabaseSchema = cdmDatabaseSchema,
    cdmVersion = cdmVersion,
    cdmSourceName = cdmSourceName,
    outputFile = 'dq-result_camel.json',
    outputFolder = datasourceReleaseOutputFolder,
    numThreads = numThreadsDQD
)

DataQualityDashboard::convertJsonResultsFileCase(
    jsonFilePath = file.path(datasourceReleaseOutputFolder, 'dq-result_camel.json'),
    writeToFile = TRUE,
    outputFile = 'dq-result.json',
    outputFolder = datasourceReleaseOutputFolder,
    targetCase = 'snake'
)

Achilles::exportToAres(
    connectionDetails = connectionDetails,
    cdmDatabaseSchema = cdmDatabaseSchema,
    resultsDatabaseSchema = cdmDatabaseSchema,
    vocabDatabaseSchema = cdmDatabaseSchema,
    outputPath = aresDataRoot
)

outputFile <- file.path(datasourceReleaseOutputFolder, "temporal-characterization.csv")
Achilles::performTemporalCharacterization(
    connectionDetails = connectionDetails,
    cdmDatabaseSchema = cdmDatabaseSchema,
    resultsDatabaseSchema = cdmDatabaseSchema,
    outputFile = outputFile
)

AresIndexer::augmentConceptFiles(releaseFolder = file.path(aresDataRoot, releaseKey))

sourceFolders <- list.dirs(aresDataRoot, recursive = F)
AresIndexer::buildNetworkIndex(sourceFolders = sourceFolders, outputFolder = aresDataRoot)
AresIndexer::buildDataQualityIndex(sourceFolders = sourceFolders, outputFolder = aresDataRoot)
AresIndexer::buildNetworkUnmappedSourceCodeIndex(sourceFolders = sourceFolders, outputFolder = aresDataRoot)
