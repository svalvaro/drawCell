#' Run Shiny app for the drawCell Package
#'
#' @export
#'
#' @import shiny
#' @import shiny.semantic
#' @import htmltools
#' @import glue
drawCellShiny <- function() {
  shiny::shinyAppDir(appDir = base::system.file("shinyApp/drawCellShiny",
    package = "drawCell"
  ))
}
