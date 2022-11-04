#' Run Shiny app for the drawCell Package
#'
#' @export
#'
#' @import shiny
#' @import shiny.semantic
#' @import htmltools
#' @import glue
#' @import colourpicker
drawCellShiny <- function() {
  shiny::shinyAppDir(appDir = base::system.file("shinyApp/drawCellShiny",
    package = "drawCell"
  ))
}
