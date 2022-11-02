#' Run Shiny app for the drawCell Package
#'
#' @return
#' @export
#'
#' @examples
drawCellShiny <- function() {
  shiny::shinyAppDir(appDir = base::system.file("shinyApp/drawCellShiny",
    package = "drawCell"
  ))
}
