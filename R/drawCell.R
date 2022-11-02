#' Creates a cell picture
#'
#' @param organism_identifier Taxonomy id of the organism of interest.
#'   Can be found at https://www.ncbi.nlm.nih.gov/taxonomy/
#' @param sl_ids Id of the subcellular location, can be found at
#'  http://current.geneontology.org/ontology/external2go/uniprotkb_sl2go
#' @param inputId input id of cell' defaults to `NULL`
#' @param width width of cell; defaults to `NULL`
#' @param height height of cell; defaults to `NULL`
#' @param elementId id of cell, defaults to `NULL`
#' @param colour_sl Highlighted color of the subcelullar components
#'
#' @import htmlwidgets
#'
#' @return Generates a PNG of the requested cell by the user with highlighted
#' subcellular elements.
#' @export
#'
#' @examples
#' drawCell(organism_identifier = '58334', sl_ids = '0049', color = 'lightblue')
#'
drawCell <-
  function(
    organism_identifier,
    sl_ids,
    inputId = NULL,
    width = NULL,
    height = NULL,
    elementId = NULL,
    colour_sl = NULL
  ) {
    # forward options using x
    x <- list(
      input_id = inputId,
      organism_identifier = organism_identifier,
      sl_ids = csl(sl_ids),
      colour_sl = csl(colour_sl)
    )
    # create widget
    htmlwidgets::createWidget(
      name = "drawCell",
      x,
      width = width,
      height = height,
      package = "drawCell",
      elementId = elementId
    )
  }
