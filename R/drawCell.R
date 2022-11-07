#' Creates a cell picture
#'
#' @param organism_identifier Taxonomy id of the organism of interest. Can be found at
#'   https://www.ncbi.nlm.nih.gov/taxonomy/
#' @param list_sl_colors Named list. The name is the id of the subcellular location, can be found at
#'   http://current.geneontology.org/ontology/external2go/uniprotkb_sl2go the value is the colour
#'   that each subcellular location should have
#' @param width  Width of the resulting image
#' @param height Height of the resulting image
#'
#' @import htmlwidgets
#'
#' @return Generates a vector image of the requested cell by the user with coloured subcellular
#'   elements.
#' @export
#'
#' @examples
#' drawCell(
#'   organism_identifier = "9606",
#'   list_sl_colors = list(
#'     "SL0095" = "green",
#'     "SL0154" = "red"
#'   )
#' )
drawCell <- function(organism_identifier, list_sl_colors, width = NULL, height = NULL) {
  # forward options using x
  x <- list(
    input_id = "cell",
    organism_identifier = organism_identifier,
    sl_ids = csl(names(list_sl_colors)),
    colour_sl = csl(list_sl_colors)
  )
  # create widget
  htmlwidgets::createWidget(
    name = "drawCell",
    x,
    width = width,
    height = height,
    package = "drawCell",
    elementId = NULL
  )
}
