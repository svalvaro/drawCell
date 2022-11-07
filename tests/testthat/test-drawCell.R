test_that("drawCell enerates a picture", {
  cell_svg <-
    drawCell(
      organism_identifier = "9060",
      list_sl_colors = list("SL0173" = "red", "SL0101" = "blue")
    )

  expect_s3_class(cell_svg, "drawCell")
  expect_s3_class(cell_svg, "htmlwidget")
  expect_equal(cell_svg[["x"]][["input_id"]], "cell")
  expect_equal(cell_svg[["x"]][["organism_identifier"]], "9060")
  expect_equal(cell_svg[["x"]][["sl_ids"]], "SL0173,SL0101")
  expect_equal(cell_svg[["x"]][["colour_sl"]], "red,blue")

})
