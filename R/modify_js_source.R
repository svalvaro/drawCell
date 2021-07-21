modify_js_source <- function(...){


    # modify the JS source file to the users location.
    # this only needs to be done once.

    custom_element <- readr::read_lines(system.file('snippets/custom_element.txt', package = 'drawCell'))



    jscode_dir <- system.file("JScode/jscode.js", package="drawCell")

    cust_new <- gsub(pattern = "souce_to_be_modified\\",
         replacement = as.character(jscode_dir),
         x = custom_element
    )


    write
}
