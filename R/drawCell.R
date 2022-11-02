#' Creates a cell picture
#'
#' @param taxonomy_id Taxonomy id of the organism of interest. Can be found at
#' https://www.ncbi.nlm.nih.gov/taxonomy/
#' @param sl_ids Id of the subcellular location, can be found at
#'  http://current.geneontology.org/ontology/external2go/uniprotkb_sl2go
#' @param delay Time needed to make picture of the HTML (webshot). If the
#' picture is blank, try increasing the delay since it might take longer to
#' render the HTML. (Units in seconds)
#' @param size Size of the cell, around 2000 should work well.
#'
#' @param color Highlited color of the subcelullar components.
#'
#' @import htmlwidgets
#'
#' @return Generates a PNG of the requested cell by the user with highligthed
#' subcellular elements.
#' @export
#'
#' @examples
#' drawCell(
#'    organism_identifier = '9606',
#'    list_sl_colors = list(
#'    'SL0095' = 'green',
#'    'SL0154'='red')
#'  )
drawCell <- function(organism_identifier, list_sl_colors,  width = NULL, height = NULL) {

  # forward options using x
  x = list(
    input_id = "cell",
    organism_identifier = organism_identifier,
    sl_ids = csl(names(list_sl_colors)),
    colour_sl = csl(list_sl_colors)
  )
  # create widget
  htmlwidgets::createWidget(
    name = 'drawCell',
    x,
    width = width,
    height = height,
    package = 'drawCell',
    elementId = NULL
  )
}
