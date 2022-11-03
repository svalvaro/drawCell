library(drawCell)
library(shiny)
library(shiny.semantic)

path <- system.file("extdata", "swissbiopics_mapping.csv", package = "drawCell")
data <- read.csv2(path, sep = ";")
path <- system.file("extdata", "uniprot.tsv", package = "drawCell")
uniprot <- read.table(file = path, sep = "\t", header = TRUE)
uniport_sc_ids <- substr(uniprot$Subcellular.location.ID, 4, 7)
