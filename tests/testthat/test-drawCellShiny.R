library(shinytest2)

test_that("sample_app works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()

  appdir <- system.file("shinyApp/drawCellShiny", package = "drawCell")
  test_app(appdir)
})
