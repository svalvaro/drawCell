#' Creates custom_element.txt
#'
#' @param ...
#'
#' @return Creates custom_element.txt inside inst/snippet/ with the path to the
#' JScode, since it will be different to each user.
#'
#' @examples
generate_custom_element <- function(...){


    jscode_dir <- system.file("JScode/jscode.js", package="drawCell")


    to_write <- paste0('<script type="module" src="', jscode_dir,
                       '"></script>
                           <script defer>
                           if (! window.customElements.get("sib-swissbiopics-sl"))
                               window.customElements.define("sib-swissbiopics-sl", SwissBioPicsSL);
                       </script>')


    readr::write_file(to_write, paste(system.file("snippets/", package="drawCell"),'custom_element.txt', sep = '/') )


}
