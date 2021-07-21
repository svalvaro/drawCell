
<!-- README.md is generated from README.Rmd. Please edit that file -->

# drawCell

<!-- badges: start -->
<!-- badges: end -->

The goal of drawCell is to easily obtain nice cell pictures in R!

## Installation

drawCell is not available at CRAN or bioconductor since it uses the
package [webshot2](https://github.com/rstudio/webshot2), which needs to
be installed.

``` r
# install.packages("devtools")
devtools::install_github("svalvaro/MQmetrics")
```

## Example

This is a basic example which shows you how to solve a common problem:

It requires the [taxonomy id](https://www.ncbi.nlm.nih.gov/taxonomy/) of
your species of interest, and one or multiple SL codes for subcellular
locations that will be colored. [This
dataset](http://current.geneontology.org/ontology/external2go/uniprotkb_sl2go)
contains the SL codes for each subcellular location.

The taxonomy id for *Quercus ilex* a common tree in the south of Spain
is `58334` and as an example I will use the SL code of the chloroplast:
`0049`.

``` r
library(drawCell)

drawCell(taxonomy_id = '58334', sl_ids = '0049')
FALSE   |                                                                              |                                                                      |   0%  |                                                                              |.........                                                             |  12%
FALSE   ordinary text without R code
FALSE 
FALSE   |                                                                              |..................                                                    |  25%
FALSE label: unnamed-chunk-2 (with options) 
FALSE List of 1
FALSE  $ echo: logi FALSE
FALSE 
FALSE   |                                                                              |..........................                                            |  38%
FALSE   ordinary text without R code
FALSE 
FALSE   |                                                                              |...................................                                   |  50%
FALSE label: unnamed-chunk-3
FALSE   |                                                                              |............................................                          |  62%
FALSE   ordinary text without R code
FALSE 
FALSE   |                                                                              |....................................................                  |  75%
FALSE label: unnamed-chunk-4 (with options) 
FALSE List of 1
FALSE  $ echo: logi FALSE
FALSE 
FALSE   |                                                                              |.............................................................         |  88%
FALSE   ordinary text without R code
FALSE 
FALSE   |                                                                              |......................................................................| 100%
FALSE label: unnamed-chunk-5 (with options) 
FALSE List of 1
FALSE  $ echo: logi FALSE
FALSE 
FALSE 
FALSE /usr/lib/rstudio/bin/pandoc/pandoc +RTS -K512m -RTS html_generator.knit.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /home/alvaro/R/x86_64-pc-linux-gnu-library/4.1/drawCell/cell_pictures/cell_picture.html --lua-filter /home/alvaro/R/x86_64-pc-linux-gnu-library/4.1/rmarkdown/rmarkdown/lua/pagebreak.lua --lua-filter /home/alvaro/R/x86_64-pc-linux-gnu-library/4.1/rmarkdown/rmarkdown/lua/latex-div.lua --self-contained --variable bs3=TRUE --standalone --section-divs --template /home/alvaro/R/x86_64-pc-linux-gnu-library/4.1/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --variable theme=bootstrap --include-in-header /tmp/RtmpEJRPYV/rmarkdown-str139b710421407.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML'
```

<img src="man/figures/README-example-1.png" width="100%" />
