test_that("Generates a picture", {

    drawCell::drawCell(taxonomy_id = '9606', sl_ids = '0101')


    dir_cell <- paste0(getwd(),'/','cell_pic.png')

    testthat::expect_true(file.exists(dir_cell))
})
