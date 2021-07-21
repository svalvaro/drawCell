#' Creates a cell
#'
#' @import rmkardown
#'
#' @return
#' @export
#'
#' @examples
drawCell <- function(taxonomy_id, sl_ids, delay = 1){

    #First generate custom_element

    generate_custom_element()

    #Determine the template
    input = system.file("Rmd_template/html_generator.Rmd", package="drawCell")

    output_dir <-  system.file("cell_pictures/", package="drawCell")

    name_picture <- 'cell_picture'

    # Create hTML picture

    rmarkdown::render(
        input = input,
        params = list(taxonomy_id = taxonomy_id,
                      sl_ids = sl_ids,
                      delay = delay),
        output_file = name_picture,
        output_dir = output_dir
    )


    # Create webshot


    webshot2::webshot(url = paste0(output_dir,name_picture, '.html'),
                      file = 'cell_pic.png',
                      delay = delay)
}
