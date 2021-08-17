#' Creates custom_element.txt
#'
#' @param ...
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

    jscode_dir <- system.file("JScode/jscode.js", package="drawCell")


    to_write <- paste0('<script type="module" src="', jscode_dir,
                       '"></script>
                           <script defer>
                           if (! window.customElements.get("sib-swissbiopics-sl"))
                               window.customElements.define("sib-swissbiopics-sl", SwissBioPicsSL);
                       </script>')


    readr::write_file(to_write, paste(system.file("snippets/", package="drawCell"),'custom_element.txt', sep = '/') )


}




#' Title
#'
#' @param items
#'
#' @return
#'
#' @examples
arguments_csl <- function(items){
    return(paste("\"", paste(htmltools::htmlEscape(unlist(items)), collapse = ",", sep = ""), "\"", sep = ""))
}



#' Generates the HTML document with the cell picture
#'
#' @param taxonomy_id
#' @param sl_ids
#' @param templates
#' @param custom_element
#' @param ...
#'
#' @return
#'
#' @examples
make_html <- function(taxonomy_id , #The NCBI taxonomy ID

                      sl_ids, #The IDs of the cellular elements to highlight.

                      # The filepath to (or raw HTML text of) the templates snippet.
                      templates = system.file("snippets/templates.txt", package="drawCell"),


                      # The filepath to (or raw HTML text of) the custom element
                      # snippet.
                      custom_element = system.file("snippets/custom_element.txt",
                                                   package="drawCell"),

                      # Further arguments to 'readr::read_file()', which might
                      # be useful to process snippet encodings across platforms.
                      ...){

    # Escape any strings supplied.
    taxonomy_id <- arguments_csl(taxonomy_id[1])
    sl_ids <- arguments_csl(sl_ids)


    # Compile all the HTML snippets into a list:
    elements <- list()


    # Include the templates (as read)...
    elements$templates <- readr::read_file(file = templates, ...)


    # ...then include the line (created here) to target the right picture...
    elements$identifier <- "<sib-swissbiopics-sl taxid=%s sls=%s></sib-swissbiopics-sl>"
    elements$identifier <- sprintf(fmt = elements$identifier, taxonomy_id, sl_ids)



    # ...and finally include the definition (as read) for the custom element.
    elements$custom_element <- readr::read_file(file = custom_element, ...)

    # # change the jscode to the user's
    #
    # elements$jscode <- "<script type= %s src = %s ></script>"
    #
    # elements$jscode <- sprintf(fmt = elements$jscode, as.character("module"),
    # system.file("JScode/jscode.js", package="drawCell"))

    # Append these snippets together, into the full HTML code.
    return(paste(unlist(elements), collapse = "\n"))

}





#' Title
#'
#' @param taxid
#' @param sls
#' @param ...
#'
#' @return
#'
#' @examples
cell_visualizer <- function(# The NCBI taxonomy ID.

    taxid = "9606",

    # A list (or vector) of the UniProtKB subcellular location
    # (SL) IDs for the cellular elements to highlight.
    sls = list("SL0073"),

    # Further arguments to 'make_html()'.
    ...
){

    # Display the interactive imagery given by the parameters, visible in both
    # RStudio (crowded) and the R Markdown file (well laid out).

    # Embed the HTML text where this function is called.
    pic = htmltools::HTML(make_html(taxonomy_id = taxid, sl_ids = sls, ...))
    return(pic)

}

#' Title
#'
#' @param heigth
#'
#' @return
#' @export
#'
#' @examples
edit_html <- function(heigth=2000){


}

