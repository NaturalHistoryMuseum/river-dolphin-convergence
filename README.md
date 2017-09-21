# Quantifying convergence in river dolphins
Author(s): Charlotte E Page and [Natalie Cooper](mailto:natalie.cooper.@nhm.ac.uk)  

This repository contains all the code and data used in the manuscript [Link to final published pdf will be here]().

To cite the paper: 
> Charlotte E. Page \& Natalie Cooper. 2017. Morphological convergence in 'river dolphin' skulls: a disparate grouping justified. [Journal tbc].

To cite this repo: 
> Charlotte E. Page \& Natalie Cooper. 2017. GitHub: NaturalHistoryMuseum/river-dolphin-convergence: Release for publication. http://dx.doi.org/10.5281/zenodo.846278.

[![DOI](https://zenodo.org/badge/98415211.svg)](https://zenodo.org/badge/latestdoi/98415211)

## Data
These analyses are based on photographs of specimens from the Natural History Museum, London. 
All the photographs are available from the [NHM Data Portal](http://dx.doi.org/10.5519/0082274). 
We then added landmarks to these to create TPS files that are used in all subsequent analyses. 
The TPS files are available in this repo (unscaled in the `rawdata/` folder and scaled with some landmarks removed in the `data/` folder), but can also be downloaded from the [NHM Data Portal](http://dx.doi.org/10.5519/0082274).

If you use the data please cite as follows: 
> Charlotte E. Page \& Natalie Cooper (2017). Dataset: Crania and mandible data from 'river dolphins' and other odontocetes. Natural History Museum Data Portal (data.nhm.ac.uk). [http://dx.doi.org/10.5519/0082274](http://dx.doi.org/10.5519/0082274).


## Analyses
All code used to run analyses and make figures is included in the `analyses/` folder. Before starting remember to either set your working directory to the **river-dolphin-convergence** folder on your computer, or open an RStudio project from that folder.

* **00-fix-tps-data.R** creates cleaned TPS files from raw data
* **01-crania-sppmean.R** and **02-mandibles-sppmean.R** are the main analyses. This code extracts generalised Procrustes aligned coordinates, takes species means of these, and then proceeds to perform principal components analyses, phylogenetic Procrustes MANOVAs, phylogenetic ANOVAs, and Stayton's (2015) C1 test for convergence.
* **03-figure-phylomorphospace-crania.R** and **04-figure-phylomorphospace-mandibles.R** plot phylomorphospaces.
* **05-figure-phenetic-tree-crania.R**	and **06-figure-phenetic-tree-mandibles.R** plot phenetic trees.
* **07-figure-simple-phylo.R** plots simple phylogenies for the paper.
* **08-figure-wireframes.R** plots the wireframe plots of major PC axes.
* **09-repeatability.R** estimates error in the form of repeatability (Zelditch et al 2012).
* **10-crania-all-specimens.R** and **11-mandibles-all-specimens.R** perform the main analyses but on specimen not species data. These analyses do not use phylogeny, so there is no estimate of Stayton's C1.

## Session Info
For reproducibility purposes, here is the output of `devtools:session_info()` used to perform the analyses in the publication.

    Session info ------------------------------------------------------------------------
    
    setting  value                       
    version  R version 3.4.1 (2017-06-30)
    system   x86_64, darwin15.6.0        
    ui       RStudio (1.0.153)           
    language (EN)                        
    collate  en_IE.UTF-8                 
    tz       Europe/Dublin               
    date     2017-08-21                  

    Packages ----------------------------------------------------------------------------
    package           * version  date       source        
    animation           2.5      2017-03-30 CRAN (R 3.4.0)
    ape               * 4.1      2017-02-14 CRAN (R 3.4.0)
    BAMMtools         * 2.1.6    2017-02-03 CRAN (R 3.4.0)
    base              * 3.4.1    2017-07-07 local         
    bitops              1.0-6    2013-08-17 CRAN (R 3.4.0)
    caTools             1.17.1   2014-09-10 CRAN (R 3.4.0)
    cluster             2.0.6    2017-03-10 CRAN (R 3.4.1)
    clusterGeneration   1.3.4    2015-02-18 CRAN (R 3.4.0)
    coda                0.19-1   2016-12-08 CRAN (R 3.4.0)
    combinat            0.0-8    2012-10-29 CRAN (R 3.4.0)
    compiler            3.4.1    2017-07-07 local         
    convevol          * 1.0      2014-12-22 CRAN (R 3.4.0)
    datasets          * 3.4.1    2017-07-07 local         
    deSolve             1.20     2017-07-14 CRAN (R 3.4.1)
    devtools            1.13.3   2017-08-02 CRAN (R 3.4.1)
    digest              0.6.12   2017-01-27 CRAN (R 3.4.0)
    expm                0.999-2  2017-03-29 CRAN (R 3.4.0)
    fastmatch           1.1-0    2017-01-28 CRAN (R 3.4.0)
    gdata               2.18.0   2017-06-06 CRAN (R 3.4.0)
    geiger            * 2.0.6    2015-09-07 CRAN (R 3.4.0)
    geomorph          * 3.0.5    2017-08-09 CRAN (R 3.4.1)
    gplots              3.0.1    2016-03-30 CRAN (R 3.4.0)
    graphics          * 3.4.1    2017-07-07 local         
    grDevices         * 3.4.1    2017-07-07 local         
    grid                3.4.1    2017-07-07 local         
    gtools              3.5.0    2015-05-29 CRAN (R 3.4.0)
    htmltools           0.3.6    2017-04-28 cran (@0.3.6) 
    htmlwidgets         0.9      2017-07-10 cran (@0.9)   
    httpuv              1.3.5    2017-07-04 cran (@1.3.5) 
    igraph              1.1.2    2017-07-21 CRAN (R 3.4.1)
    jpeg                0.1-8    2014-01-23 CRAN (R 3.4.0)
    jsonlite            1.5      2017-06-01 CRAN (R 3.4.0)
    KernSmooth          2.23-15  2015-06-29 CRAN (R 3.4.1)
    knitr               1.17     2017-08-10 cran (@1.17)  
    lattice             0.20-35  2017-03-25 CRAN (R 3.4.1)
    magrittr            1.5      2014-11-22 CRAN (R 3.4.0)
    maps              * 3.2.0    2017-06-08 CRAN (R 3.4.0)
    MASS              * 7.3-47   2017-02-26 CRAN (R 3.4.1)
    Matrix              1.2-10   2017-05-03 CRAN (R 3.4.1)
    memoise             1.1.0    2017-04-21 CRAN (R 3.4.0)
    methods           * 3.4.1    2017-07-07 local         
    mime                0.5      2016-07-07 CRAN (R 3.4.0)
    mnormt              1.5-5    2016-10-15 CRAN (R 3.4.0)
    msm                 1.6.4    2016-10-04 CRAN (R 3.4.0)
    mvtnorm             1.0-6    2017-03-02 CRAN (R 3.4.0)
    nlme                3.1-131  2017-02-06 CRAN (R 3.4.1)
    numDeriv            2016.8-1 2016-08-27 CRAN (R 3.4.0)
    parallel            3.4.1    2017-07-07 local         
    phangorn            2.2.0    2017-04-03 CRAN (R 3.4.0)
    phytools          * 0.6-20   2017-07-28 CRAN (R 3.4.1)
    pkgconfig           2.0.1    2017-03-21 CRAN (R 3.4.0)
    plotrix             3.6-5    2017-05-10 CRAN (R 3.4.0)
    quadprog            1.5-5    2013-04-17 CRAN (R 3.4.0)
    R6                  2.2.2    2017-06-17 CRAN (R 3.4.0)
    Rcpp                0.12.12  2017-07-15 CRAN (R 3.4.1)
    rgl               * 0.98.1   2017-03-08 cran (@0.98.1)
    rstudioapi          0.6      2016-06-27 CRAN (R 3.4.0)
    scatterplot3d       0.3-40   2017-04-22 CRAN (R 3.4.0)
    shiny               1.0.3    2017-04-26 cran (@1.0.3) 
    splines             3.4.1    2017-07-07 local         
    stats             * 3.4.1    2017-07-07 local         
    subplex             1.4-1    2017-07-18 CRAN (R 3.4.1)
    survival            2.41-3   2017-04-04 CRAN (R 3.4.1)
    tools               3.4.1    2017-07-07 local         
    utils             * 3.4.1    2017-07-07 local         
    withr               2.0.0    2017-07-28 CRAN (R 3.4.1)
    xtable              1.8-2    2016-02-05 cran (@1.8-2) 

## Checkpoint for reproducibility
To rerun all the code with packages as they existed on CRAN at time of our analyses we recommend using the `checkpoint` package, and running this code prior to the analysis:

```{r}
checkpoint("2017-08-17")
```

