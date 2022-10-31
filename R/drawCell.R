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
#' drawCell(taxonomy_id = '58334',
#' sl_ids = '0049',
#' size = 2000,
#' color = 'lightblue')
#' <Add Title>
#'
#' <Add Description>
drawCell <- function(organism_identifier, sl_ids, inputId = NULL, width = NULL, height = NULL, elementId = NULL, colour_sl = NULL) {

  
  # forward options using x
  x = list(
    input_id = inputId,
    organism_identifier = organism_identifier,
    sl_ids = csl(sl_ids),
    colour_sl = csl(colour_sl)
  )
  # create widget
  htmlwidgets::createWidget(
    name = 'drawCell',
    x,
    width = width,
    height = height,
    package = 'drawCell',
    elementId = elementId
  )
}
