#--------------------------------------------------------------
# Phylomorphospace plots for dolphin mandibles
# Charlotte Page 2017
# Modified by Natalie Cooper 2017

# STEP 1: Input shape data
# Input coordinate data
# GPA (Generalised Procrustes Analysis)
# Extract species mean shape coordinates

# STEP 2: Read in the phylogeny and prune to our species

# STEP 3: Principal components analysis

# STEP 4: Plot phylomorphospaces for PC1 vs PC2, PC2 vs PC3 
# and PC1 vs PC3

#-------------------------------------
# Setup
#-------------------------------------
# Setwd as the folder for this project
# or open a new project there

# Load libraries
library(ape)
library(rgl)
library(geomorph)
library(geiger)
library(phytools)
library(BAMMtools)

#----------------------------------------------
# STEP 1: Input and ordinate shape data
#----------------------------------------------

# Read in the landmarked data
# These data are TPS files produced in tpsDig
# a program allowing easy landmarking of images
#----------------------------------------------
# Read in landmark coordinates
# Note that this will warn that there is no scale data
# These data were previously scaled in 00-fix-tps-data.R
# See /rawdata for unscaled coordinates
mandible <- readland.tps(file = "data/dolphin-mandibles.TPS",
                       specID = "ID",
                       readcurves = TRUE,
                       warnmsg = TRUE)

# Define sliders
# NOT RUN
# mysliders <- define.sliders(mandible, 8, write.file = TRUE) 
# This takes a long time so we have provided the curveslide file it creates

# Read in curves
curves <- as.matrix(read.csv("data/dolphin-mandibles-curves.csv", header = TRUE))

#------------------------------------------------------
# Merge landmark data file with additional information 
# i.e. species names, river dolphin/ not river dolphin
#------------------------------------------------------
# Read in metadata on specimens
ds <- read.csv("data/dolphin-mandibles-data.csv")

#-------------------------------------
# General Procrustes alignment (GPA)
# of all scaled coordinates
#-------------------------------------
gpa <- gpagen(mandible, curves, ProcD = TRUE)

#--------------------------------------------------------------
# Group GPA coordinates by species and get species mean shapes
#--------------------------------------------------------------
# Sort dataset by the order of specimens in the GPA
ordered.data <- ds[match(dimnames(gpa$coords)[[3]], ds$image), ]

# Create a 2D array that aggregate can work on
two.d.coords <- two.d.array(gpa$coords)

# Aggregate by species, and remove the species from the 
# output columns, then add back in as row names
species.means <- aggregate(two.d.coords ~ ordered.data$species, FUN = mean)[,-1]
rownames(species.means) <- levels(ordered.data$species)

# Make species.means into a 3D array again
mean.coords <- arrayspecs(species.means, dim(gpa$coords)[1], dim(gpa$coords)[2])

# Sort dataset by the order of specimens in the species means array
mydata <- ds[match(dimnames(mean.coords)[[3]], ds$species), ]

# Put it all together for further analyses
species.data <- list(coords = mean.coords,
                    species = mydata$species,
                    river = mydata$river)

#----------------------------------------------
# STEP 2: Read in the phylogeny and prune
# to our species
#-------------------------------------
# Tree is within BAMMtools which saves time!
data(BAMMtools::whales)
data(whales)

# Extract only the odontocetes
node <- findMRCA(whales, c("Kogia_simus", "Delphinus_delphis"))
odonto <- extract.clade(whales, node)

# Match up species in tree and dataset
# All species should in the the tree, but some are missing from the data
check <- name.check(odonto, species.data, data.names = species.data$species)
whaletree <- drop.tip(odonto, check$tree_not_data)

#---------------------------------------------
# STEP 3: Principal components analysis (PCA)
#---------------------------------------------
# PCA 
pca.lands <- plotTangentSpace(species.data$coords, 
                              groups = as.factor(species.data$river),
                              legend = TRUE, label = TRUE)

# Make a new dataframe
pca <- data.frame(pca.lands$pc.scores,
	              species = species.data$species,
	              river = species.data$river)

# Sort PCA data based on the tip labels of the phylogeny
# to help with colouring tips in plots
pca <- pca[match(whaletree$tip.label, pca$species), ]

# ----------------------------------
# STEP 4: Plot the phylomorphospaces
# ----------------------------------
# Create a colour vector (in the order of the tips, then nodes)
# River dolphin tips will be blue, others grey and nodes black
plot.colours <- c("gray56", "deepskyblue3")
cols <- c(plot.colours[pca2$river], rep("black", whaletree$Nnode))
names(cols)<- 1:(length(whaletree$tip.label) + whaletree$Nnode)

# Plot the phylomorphospaces 
# Exclude taxon names to make plots clearer
phylomorphospace(whaletree, pca[, 1:2], control = list(col.node = cols), label = "off")
phylomorphospace(whaletree, pca[, c(1, 3)], control = list(col.node = cols), label ="off")
phylomorphospace(whaletree, pca[, 2:3], control = list(col.node = cols), label = "off")