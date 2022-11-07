#' Run Shiny app for the drawCell Package
#'
#' @export
drawCellShiny <- function() {
  shiny::shinyAppDir(appDir = base::system.file("shinyApp/drawCellShiny",
    package = "drawCell"
  ))
}
