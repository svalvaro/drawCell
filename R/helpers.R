#' Creates custom_element.txt
#'
#' @param ... it doesn't need anything
#'
#' @importFrom readr write_file
#'
#' @return Creates custom_element.txt inside inst/snippet/ with the path to the
#' JScode, since it will be different to each user.
#'
#' @examples
generate_custom_element <- function(...){


    # This function is necessary to change the source of the JS code module
    # of each user.


    # This can be a temporary file.

    jscode_dir <- system.file("JScode/jscode.js", package="drawCell")


    to_write <- paste0('<script type="module" src="', jscode_dir,
                       '"></script>
                           <script defer>
                           if (! window.customElements.get("sib-swissbiopics-sl"))
                               window.customElements.define("sib-swissbiopics-sl", SwissBioPicsSL);
                       </script>')


    readr::write_file(to_write, paste(system.file("snippets/",
                                                package="drawCell"),
                                        'custom_element.txt', sep = '/') )


}




#' argument_csl
#'
#' @param items sl_ids, tax_id
#'
#' @return str with sl_ids and tax_id
#' @importFrom htmltools htmlEscape
#'
#' @examples
arguments_csl <- function(items){
    return(paste("\"", paste(htmltools::htmlEscape(unlist(items)),
                            collapse = ",", sep = ""), "\"", sep = ""))
}



#' Generates the HTML document with the cell picture
#'
#' @param taxonomy_id taxonomy id
#' @param sl_ids subcelullar ids
#' @param templates snippets folders template.txt
#' @param custom_element snippets folders custom.txt
#'
#' @importFrom readr read_file
#' @return html document
#'
#' @examples
make_html <- function(taxonomy_id , #The NCBI taxonomy ID

                  sl_ids, #The IDs of the cellular elements to highlight.

                  # The filepath to (or raw HTML text of) the templates snippet.
                  templates = system.file("snippets/templates.txt",
                                        package="drawCell"),


                  # The filepath to (or raw HTML text of) the custom element
                  # snippet.
                  custom_element = system.file("snippets/custom_element.txt",
                                               package="drawCell")){

    # Escape any strings supplied.
    taxonomy_id <- arguments_csl(taxonomy_id[1])
    sl_ids <- arguments_csl(sl_ids)


    # Compile all the HTML snippets into a list:
    elements <- list()


    # Include the templates (as read)...
    elements$templates <- readr::read_file(file = templates)

    # ...then include the line (created here) to target the right picture...
    elements$identifier <- "<sib-swissbiopics-sl taxid=%s sls=%s></sib-swissbiopics-sl>"
    elements$identifier <- sprintf(fmt = elements$identifier,
                                   taxonomy_id,
                                   sl_ids)



    # ...and finally include the definition (as read) for the custom element.
    elements$custom_element <- readr::read_file(file = custom_element)

    # # change the jscode to the user's
    #
    # elements$jscode <- "<script type= %s src = %s ></script>"
    #
    # elements$jscode <- sprintf(fmt = elements$jscode, as.character("module"),
    # system.file("JScode/jscode.js", package="drawCell"))

    # Append these snippets together, into the full HTML code.
    return(paste(unlist(elements), collapse = "\n"))

}


#' generates the html document
#'
#' @param taxid taxonomy id
#' @param sls subcellular ids
#'
#' @return html document
#' @importFrom htmltools HTML
#'
#' @examples
cell_visualizer <- function(# The NCBI taxonomy ID.

    taxid = "9606",

    # A list (or vector) of the UniProtKB subcellular location
    # (SL) IDs for the cellular elements to highlight.
    sls = list("SL0073")
){

    # This to be change into a temporary file.

    # Display the interactive imagery given by the parameters, visible in both
    # RStudio (crowded) and the R Markdown file (well laid out).

    # Embed the HTML text where this function is called.
    pic = htmltools::HTML(make_html(taxonomy_id = taxid, sl_ids = sls))
    return(pic)
}

#' changes the size of the cell
#'
#' @param size size of the highlited element
#'
#' @return html modified with size
#'
#'
#' @examples
edit_html <- function(size=2000){

    html_path <- system.file('cell_pictures/cell_picture.html',
                            package = 'drawCell')
    html <- readr::read_file(html_path)


    pattern <- paste0('max-width: ', size, 'px')

    html <- gsub('max-width: 940px', pattern, html[1])

    readr::write_file(html, html_path)

}


#' Changes the color of the cell
#'
#' @param color Color of the highlited element
#'
#' @return jscode modified with the color selected
#'
#' @examples
edit_jscode <- function(color = 'blue'){

    js_path <- system.file('JScode/jscode.js', package = 'drawCell')

    js_code <- readr::read_file(js_path)

    # Substitute the lightyellow color to the chosen color.
    # Since this modifies permantly the js code. Then it needs to be restored
    # Otherwise gsub will not be able to change it again.
    js_code <- gsub('fill: lightyellow', paste0('fill: ', color), js_code)


    js_code <- gsub('background-color: lightyellow',
                    paste0('background-color: ',color), js_code)

    readr::write_file(js_code, js_path)
}


#' Restores the javascript code
#'
#' @param color Color of the highlited element
#'
#' @return jscode restored from the color selected
#'
#' @examples
restore_jscode <- function(color = 'blue'){

    # Restore the code to lightyellow

    js_path <- system.file('JScode/jscode.js', package = 'drawCell')

    js_code <- readr::read_file(js_path)

    js_code <- gsub(paste0('fill: ', color), 'fill: lightyellow', js_code)
    js_code <- gsub(paste0('background-color: ', color),
                    'background-color: lightyellow', js_code)

    readr::write_file(js_code, js_path)
}
