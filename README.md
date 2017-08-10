# Quantifying convergence in river dolphins
Author(s): Charlotte E Page and [Natalie Cooper](mailto:natalie.cooper.@nhm.ac.uk)  

This repository contains all the code and data used in the manuscript [Link to final published pdf will be here]().

## Data
These analyses are based on photographs of specimens from the Natural History Museum, London. 
All the photographs are available [here](add link). 
We then added landmarks to these to create TPS files that are used in all subsequent analyses. 
The TPS files are available in this repo (unscaled in the `rawdata/` folder and scaled with some landmarks removed in the `data/` folder), but can also be downloaded from the NHM Data Portal. [add link here]().

If you use the data please cite the Data Portal DOI: add DOI.


## Analyses
All code used to run analyses and make figures is included in the `analyses/` folder. Before starting remember to either set your working directory to the **river-dolphin-convergence** folder on your computer, or open you RStudio project from that folder.

* **00-fix-tps-data.R** creates cleaned TPS files from raw data
* **01-crania-sppmean.R** and **02-mandibles-sppmean.R** are the main analyses. This code extracts generalised Procrustes aligned coordinates, takes species means of these, and then proceeds to perform principal components analyses, phylogenetic Procrustes MANOVAs, phylogenetic ANOVAs, and Stayton's (2015) C1 test for convergence.
* **03-figure-phylomorphospace-crania.R** and **04-figure-phylomorphospace-mandibles.R** plot phylomorphospaces.
* **05-figure-phenetic-tree-crania.R**	and **06-figure-phenetic-tree-mandibles.R** plot phenetic trees.
* **07-figure-simple-phylo.R** plots simple phylogenies for the paper.
* **08-figure-wireframes.R** plots the wireframe plots of major PC axes.
* **09-repeatability.R** estimates error in the form of repeatability (Zelditch et al 2012).
* **10-crania-all-specimens.R** and **11-mandibles-all-specimens.R** perform the main analyses but on specimen not species data. These analyses do not use phylogeny, so there is no estimate of Stayton's C1.

