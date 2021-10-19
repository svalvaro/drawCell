#' Creates a cell picture
#'
#' @param taxonomy_id Taxonomy id of the organism of interest. Can be found at
#' https://www.ncbi.nlm.nih.gov/taxonomy/
#' @param sl_ids Id of the subcellular location, can be found at
#'  http://current.geneontology.org/ontology/external2go/uniprotkb_sl2go
#' @param delay Time needed to make picture of the HTML (webshot). If the
#' picture is blank, try increasing the delay since it might take longer to
#' render the HTML. (Units in seconds)
#' @param size Size of the cell, around 2000 should work well.
#'
#' @param color Highlited color of the subcelullar components.
#'
#' @import rmarkdown
#' @importFrom  webshot2 webshot
#' @importFrom taxize get_ids
#'
#' @return Generates a PNG of the requested cell by the user with highligthed
#' subcellular elements.
#' @export
#'
#' @examples
#' drawCell(taxonomy_id = '58334',
#' sl_ids = '0049',
#' size = 2000,
#' color = 'lightblue')
drawCell <- function(organism_identifier,
                    sl_ids,
                    color = 'blue',
                    size = 2000,
                    delay = 1
                    ){

    # Organism can be provided the taxonomy id or the name of the species.

    #IF the user provides a number ( the taxonomy id itself)

    # If is a species 'Homo sapiens' when as.numeric it will return NA

    if (is.na(as.numeric(organism_identifier))) {

        taxonomy_id <- taxize::get_ids(
            sci_com = organism_identifier,
            db = 'ncbi'
        )

        taxonomy_id <- taxonomy_id$ncbi[1]
    }else{
        taxonomy_id <- organism_identifier
    }



    # Generate a cell_pictures folder if it does not exist

    dir_cell_pic <- system.file('cell_pictures/', package = 'drawCell')

    if (base::dir.exists(dir_cell_pic) == FALSE) {
        base::dir.create(paste0(system.file(package = 'drawCell'),
                                '/','cell_pictures'))
    }


    #First generate custom_element

    drawCell:::generate_custom_element()

    #Determine the template
    input = system.file("Rmd_template/html_generator.Rmd", package="drawCell")

    #output_dir <-  system.file("cell_pictures/", package="drawCell")

    htmlOutTmp <- base::tempdir()

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
        output_dir = htmlOutTmp
    )

    # Edit the HTML with the specified size:

    drawCell:::edit_html(size = size,
                         html_path = paste0(htmlOutTmp,'/',name_picture, '.html') )

    # Restore the colour to the original js code

    drawCell:::restore_jscode(color = color)

    # Create webshot as a temp file

    destFile <- base::tempfile(fileext = '.png')

    message(paste0('The tmp file is: ', destFile))

    # Create a png out of the html output with webshot2.
    # It requires to have google chrome installed.

    webshot2::webshot(url = paste0(htmlOutTmp,'/',name_picture, '.html'),
                    file = destFile,
                    vwidth = 2000,
                    vheight = 2000,
                    delay = delay)

    # Lastly render the picture as a plot

    cellPNG <- png::readPNG(source = destFile)

    message('Cell picture created: ', !is.null(cellPNG))



    return(
        grid::grid.raster(cellPNG)
    )
}
