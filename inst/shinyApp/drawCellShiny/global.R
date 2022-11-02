library(drawCell)
library(shiny)
library(shiny.semantic)

path = system.file("extdata", "swissbiopics_mapping.csv", package = "drawCell")
data = read.csv2(path, sep = ";")
path = system.file("extdata", "uniprot.tsv", package = "drawCell")
uniprot = read.table(file = path, sep = '\t', header = TRUE)
uniport_sc_ids = substr(uniprot$Subcellular.location.ID, 4, 7)

cell_name <- unique(data$Image.name)
cell_name <- cell_name[!is.na(cell_name)]

csl <- function(items) {
  return(paste(paste(htmltools::htmlEscape(unlist(items)), collapse = ",", sep = ""), sep = ""))
}

find_sc = function(id) {
  uniprot[which(uniport_sc_ids == id), ]$Name
}
