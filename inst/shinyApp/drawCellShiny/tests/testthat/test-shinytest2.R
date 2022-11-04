library(shinytest2)

test_that("drawCellShiny works", {
  app <- AppDriver$new(name = "drawCellShiny works", seed = 20, height = 1081, width = 1619)
  app$expect_values()
  app$set_inputs(cell_sl_color_rows_current = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_rows_all = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_state = c(
    1667531238102, 0, 10, "", TRUE, FALSE, TRUE,
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)
  ), allow_no_input_binding_ = TRUE)
  app$expect_values()
  app$set_inputs(colourInput = "#EB5779")
  app$set_inputs(cell_sl_color_rows_current = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_rows_all = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_state = c(
    1667531250332, 0, 10, "", TRUE, FALSE, TRUE,
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)
  ), allow_no_input_binding_ = TRUE)
  app$expect_values()
  app$set_inputs(cell_sl_color_rows_current = c(1, 2), allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_rows_all = c(1, 2), allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_state = c(
    1667531259253, 0, 10, "", TRUE, FALSE, TRUE,
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)
  ), allow_no_input_binding_ = TRUE)
  app$expect_values()
  app$set_inputs(colourInput = "#57EDA0")
  app$set_inputs(cell_sl_color_rows_current = c(1, 2), allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_rows_all = c(1, 2), allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_state = c(
    1667531266560, 0, 10, "", TRUE, FALSE, TRUE,
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)
  ), allow_no_input_binding_ = TRUE)
  app$expect_values()
  app$click("clear_color")
  app$expect_values()
  app$set_inputs(cell_type = "")
  app$expect_values()
  app$set_inputs(taxIdInput = "6096")
  app$expect_values()
  app$set_inputs(taxIdInput = "")
  app$expect_values()
  app$set_inputs(cell_type = "Fission yeast cell")
  app$expect_values()
  app$set_inputs(cell_sl_color_rows_current = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_rows_all = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_state = c(
    1667531330235, 0, 10, "", TRUE, FALSE, TRUE,
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)
  ), allow_no_input_binding_ = TRUE)
  app$expect_values()
  app$set_inputs(cell_click = "SL0041", allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_rows_current = c(1, 2), allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_rows_all = c(1, 2), allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_state = c(
    1667531336672, 0, 10, "", TRUE, FALSE, TRUE,
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)
  ), allow_no_input_binding_ = TRUE)
  app$expect_values()
  app$set_inputs(cell_sl_color_rows_current = c(1, 2), allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_rows_all = c(1, 2), allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_state = c(
    1667531343870, 0, 10, "", TRUE, FALSE, TRUE,
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)
  ), allow_no_input_binding_ = TRUE)
  app$set_inputs(colourInput = "#F05881")
  app$set_inputs(cell_sl_color_rows_current = c(1, 2), allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_rows_all = c(1, 2), allow_no_input_binding_ = TRUE)
  app$set_inputs(cell_sl_color_state = c(
    1667531351627, 0, 10, "", TRUE, FALSE, TRUE,
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)
  ), allow_no_input_binding_ = TRUE)
  app$expect_values()
  app$click("clear_color")
  app$expect_values()
})
