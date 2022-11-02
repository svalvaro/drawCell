
<!-- README.md is generated from README.Rmd. Please edit that file -->

# drawCell

<!-- badges: start -->
<!-- badges: end -->

The goal of drawCell is to easily obtain nice cell pictures in R!

## Installation

To obtain the cell pictures, `drawCell` connects to the [SwissBioPics
API](https://www.swissbiopics.org/) so an internet connection is
required.

``` r
# install.packages("devtools")
devtools::install_github("svalvaro/drawCell")
```

## Examples

It requires the
[`organism_identifier`](https://www.ncbi.nlm.nih.gov/taxonomy/) of your
species of interest, and one or multiple SL codes for subcellular
locations that will be colored. The SL codes for each subcellular
location can be found at [Uniprot](https://www.uniprot.org/docs/subcell)
and
[uniprotkb_sl2go](http://current.geneontology.org/ontology/external2go/uniprotkb_sl2go).

To generate a cell of Homo sapiens (`organism_identifier`: `9606`) with
highlighted Endoplasmic Reticulum (SL code: `0095`) and lipid droplets
(SL code: `0154`):

``` r
library(drawCell)
drawCell(organism_identifier = '9606', sl_ids = c('0095','0154'), colour_sl = 'yellow')
```

The `organism_identifier` for *Quercus ilex* a common tree in the south
of Spain is `58334` and as an example I will use the SL code of the
chloroplast: `0049`.

``` r

drawCell(organism_identifier = '58334', sl_ids = '0049', colour_sl = 'lightgreen')
```

We can also obtain pictures of viruses, yeast, and pretty much
everything that exists!

For the baker’s yeast *Saccharomyces cerevisiae* whose
`organism_identifier` is `4932` we will highlight the nucleus: `0191`
and the vacuole: `0272`.

``` r
drawCell(organism_identifier = '4932', sl_ids = c('0191', '0272'), colour_sl = 'pink')
```
