test_that("Can edit jscode in the package folder", {

    # Change the color to brown in the javascript code

    drawCell:::edit_jscode(color = 'brown')

    js_path <- system.file('JScode/jscode.js', package = 'drawCell')

    js_code <- readr::read_file(js_path)



    testthat::expect_true(grepl('brown', js_code))

    # Restore the jscode

    drawCell:::restore_jscode(color = 'brown')
})
