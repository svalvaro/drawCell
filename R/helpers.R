#' Shiny bindings for drawCell
#'
#' Output and render functions for using drawCell within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a drawCell
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name drawCell-shiny
#'
#' @export
drawCellOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "drawCell", width, height, package = "drawCell")
}

#' @rdname drawCell-shiny
#' @export
renderDrawCell <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, drawCellOutput, env, quoted = TRUE)
}

#' @export
csl <- function(items) {
  return(paste(paste(htmltools::htmlEscape(unlist(items)), collapse = ",", sep = ""), sep = ""))
}

#' @export
find_sc <- function(id) {
  uniprot[which(uniport_sc_ids == id), ]$Name
}
