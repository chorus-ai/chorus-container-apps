#!/usr/bin/env Rscript

args <- commandArgs(TRUE)
if (length(args) != 1) {
    stop(sprintf("Usage: %s <dataroot>", commandArgs()[1]))
}

aresDataRoot <- args[1]
#Note - add source release extraction and data validation processes here
sourceFolders <- list.dirs(aresDataRoot, recursive = F)
AresIndexer::buildNetworkIndex(sourceFolders = sourceFolders, outputFolder = aresDataRoot)
AresIndexer::buildDataQualityIndex(sourceFolders = sourceFolders, outputFolder = aresDataRoot)
AresIndexer::buildNetworkUnmappedSourceCodeIndex(sourceFolders = sourceFolders, outputFolder = aresDataRoot)
