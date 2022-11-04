library(shinytest2)

test_that("drawCellShinys works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()

  appdir <- system.file("shinyApp/drawCellShiny", package = "drawCell")
  suppressWarnings(test_app(appdir))
})
