#' Creates a cell picture
#'
#' @param taxonomy_id Taxonomy id of the organism of interest. Can be found at
#' https://www.ncbi.nlm.nih.gov/taxonomy/
#' @param sl_ids Id of the subcellular location, can be found at
#'  http://current.geneontology.org/ontology/external2go/uniprotkb_sl2go
#' @param delay Time needed to make picture of the HTML (webshot). If the
#' picture is blank, try increasing the delay since it might take longer to
#' render the HTML. (Units in seconds)
#' @param size
#'
#' @import rmarkdown
#' @importFrom  webshot2 webshot
#'
#' @return Generates a PNG of the requested cell by the user with highligthed
#' subcellular elements.
#' @export
#'
#' @examples
drawCell <- function(taxonomy_id,
                     sl_ids,
                     color = 'blue',
                     size = 2000,
                     delay = 1){

    # Generate a cell_pictures folder


    dir.create(paste0(system.file(package = 'drawCell'),'/','cell_pictures'))



    #First generate custom_element

    drawCell:::generate_custom_element()

    #Determine the template
    input = system.file("Rmd_template/html_generator.Rmd", package="drawCell")

    output_dir <-  system.file("cell_pictures/", package="drawCell")

    name_picture <- 'cell_picture'


    # Edit the JS code with the color of the user:

    drawCell:::edit_jscode(color = color)

    # Create hTML picture

    rmarkdown::render(
        input = input,
        params = list(taxonomy_id = taxonomy_id,
                      sl_ids = sl_ids,
                      delay = delay),
        output_file = name_picture,
        output_dir = output_dir
    )


    # Edit the HTML with the specified size:

    drawCell:::edit_html(size = size)



    # Restore the colour to the original js code

    drawCell:::restore_jscode(color = color)

    # Create webshot


    webshot2::webshot(url = paste0(output_dir,name_picture, '.html'),
                      file = 'cell_pic.png',
                      vwidth = 2000,
                      vheight = 2000,

                      delay = delay)



}
