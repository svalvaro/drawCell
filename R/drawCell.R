#' Creates a cell
#'
#' @import rmkardown
#'
#' @return
#' @export
#'
#' @examples
drawCell <- function(taxonomy_id, sl_ids, delay = 1){

    #Determine the template
    input = system.file("Rmd_template/html_generator.Rmd", package="drawCell")

    output_dir = system.file("cell_pictures/", package="drawCell")


    rmarkdown::render(
        input = input,
        params = list(taxonomy_id = taxonomy_id,
                      sl_ids = sl_ids,
                      delay = delay),
        output_file = 'pics',
        output_dir = output_dir
    )
}
