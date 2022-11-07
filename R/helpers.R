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
drawCellOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "drawCell", width, height, package = "drawCell")
}

#' @rdname drawCell-shiny
renderDrawCell <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, drawCellOutput, env, quoted = TRUE)
}

csl <- function(items) {
  return(paste(paste(htmltools::htmlEscape(unlist(items)), collapse = ",", sep = ""), sep = ""))
}

find_sc  <-  function(id) {
  uniprot[which(uniport_sc_ids == id), ]$Name
}

create_code_to_copy <- function(taxID, list_sl_colours) {

  string_colors  <-  ""

  for (i in seq_len(length(list_sl_colours))) {
    string_colors <- glue::glue(
      '{string_colors}, "{names(list_sl_colours[i])}" = "{list_sl_colours[[i]]}"'
      )
  }
  # Remove the first , from the string
  string_colors <- sub(".", "", string_colors)

  return(
    glue::glue(
      "library(drawCell)
      drawCell({taxID}, list({string_colors}))
      "
    )
  )
}

find_unique_sl <- function(cell_type) {
  switch(cell_type,
         # If the user want's to see a neuron cell, this will be produced by taxID = 6072 and SL =
         # "SL0288", However, if the user wants to see a muscle cell next, we need to clear the
         # subcellular_colours list otherwise the SL of the neuron will be there and we will fetch a
         # neuron again.
         `Animal cell` = list("SL0073" = "white"),
         `Animal neuronal cell` = list("SL0288" = "white"),
         `Animal epithelial cell` = list("SL0038" = "white"),
         `Animal muscle cell` = list("SL0315" = "white"),
         `Animal photoreceptor cell` = list("SL0458" = "white"),
         `Animal spermatozoa cell` = list("SL0199" = "white"),
         `Animal egg cell` = list("SL0540" = "white"),
         `Cnidocyte cell` = list("SL0177" = "white"),
         list("SL0000" = "#56B4E9")
  )
}
