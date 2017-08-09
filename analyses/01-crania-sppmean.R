#--------------------------------------------------------------
# Geometric morphometric analyses of species mean cranium data
# Charlotte Page 2017
# Modified by Natalie Cooper 2017

# STEP 1: Input and ordinate shape data
# Input coordinate data
# GPA (Generalised Procrustes Analysis)
# Extract species mean shape coordinates

# STEP 2: Tests for convergence 
# Procrustes ANOVA on GPA coordinates with phylogenetic correction
# PCA to explore shape variation
# Phylogenetic ANOVA on first three principal components (PCs) individually 
# to see which PCs are significantly different
# Stayton's distance-based metric

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
library(maps)
library(phytools)
library(BAMMtools)
library(convevol)

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
skull <- readland.tps(file = "data/dolphin-crania.TPS",
                       specID = "ID",
                       readcurves = TRUE,
                       warnmsg = TRUE)

# Define sliders
# NOT RUN
# mysliders <- define.sliders(skull, 8, write.file = TRUE) 
# This takes a long time so we have provided the curveslide file it creates

# Read in curves
curves <- as.matrix(read.csv("data/dolphin-crania-curves.csv", header = TRUE))

#------------------------------------------------------
# Merge landmark data file with additional information 
# i.e. species names, river dolphin/ not river dolphin
#------------------------------------------------------
# Read in metadata on specimens
ds <- read.csv("data/dolphin-crania-data.csv")

#-------------------------------------
# General Procrustes alignment (GPA)
# of all scaled coordinates
#-------------------------------------
gpa <- gpagen(skull, curves, ProcD = TRUE)

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

# Sort dataset by the order of species in the species means array
mydata <- ds[match(dimnames(mean.coords)[[3]], ds$species), ]

# Put it all together for further analyses
species.data <- list(coords = mean.coords,
                    species = mydata$species,
                    river = mydata$river)

#-------------------------------------
# STEP 2: Testing for convergence
#-------------------------------------
# Read in the phylogeny and add to data
# for further analyses
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

# Add phylogeny to dataset
gdf <- geomorph.data.frame(coords = species.data$coords,
                           phy = whaletree,
                           group = species.data$river)

#-------------------------------------------------
# Calculate phylogenetic signal (multivariate K)
# to test whether there is phylogenetic signal in
# skull shape of the species
#-------------------------------------------------
phy1 <- physignal(species.data$coords, whaletree)
summary(phy1)
# K = 1.1412 
# p-value = 0.001

#------------------------------------------------------
# Run MANOVAs on GPA coords with phylogeny accounted for
# to determine if river dolphins are significantly 
# different to other dolphins
#-------------------------------------------------------

# GPA MANOVA with randomize residuals RRPP method
manova <- procD.pgls(coords ~ group, phy = phy, data = gdf, iter =  999, RRPP = TRUE) 
summary(manova)

# Plot resulting phylomorphospace
plotGMPhyloMorphoSpace(gdf$phy, gdf$coords, tip.labels = TRUE, node.labels = TRUE,
                       ancStates = TRUE, xaxis = 1, yaxis = 2, zaxis = NULL, 
                       plot.param = list(), shadow = FALSE)

#------------------------------------
# Principal components analysis (PCA)
#------------------------------------
# PCA 
pca.lands <- plotTangentSpace(species.data$coords, 
                              groups = as.factor(species.data$river),
                              legend = TRUE, label = TRUE)

# Summary of variance associated with each PCA axis
pca.lands$pc.summary

# PC scores for each species
pca.lands$pc.scores

# Show barplot of variance explained by each PC
barplot(pca.lands$pc.summary$sdev^2 / 
        sum(pca.lands$pc.summary$sdev^2))

# Eigenvectors
pca.lands$rotation

# Create dataframe for further analysis
pc.scores <- data.frame(pca.lands$pc.scores,
                        species = species.data$species,
                        river = species.data$river)

#--------------------------------------------------------
# Phylogenetic ANOVAs to test whether individual PCs
# are significantly different in river dolphins and other
# dolphins
#--------------------------------------------------------

# PC1
pcscore1 <- pc.scores[, 1]
names(pcscore1) <- pc.scores$species
group <- as.factor(pc.scores$river)
names(group) <- names(pcscore1)

aov.phylo(pcscore1 ~ group, whaletree, nsim = 1000)

# PC2
pcscore2 <- pc.scores[, 2]
names(pcscore2) <- pc.scores$species
group <- as.factor(pc.scores$river)
names(group) <- names(pcscore2)

aov.phylo(pcscore2 ~ group, whaletree, nsim = 1000)

# PC3
pcscore3 <- pc.scores[, 3]
names(pcscore3) <- pc.scores$species
group <- as.factor(pc.scores$river)
names(group) <- names(pcscore3)

aov.phylo(pcscore3 ~ group, whaletree, nsim = 1000)

# PC4
pcscore4 <- pc.scores[, 4]
names(pcscore4) <- pc.scores$species
group <- as.factor(pc.scores$river)
names(group) <- names(pcscore4)

aov.phylo(pcscore3 ~ group, whaletree, nsim = 1000)

#----------------------------------------------
# Stayton's distance-based convergence metrics
#----------------------------------------------
# Create data object for convevol functions
# This selects just the first three PCs
pc.data <- as.matrix(array(pc.scores[, 1:3]))

# Select tips that are river dolphins
rivertips <- c("Inia_geoffrensis",
               "Lipotes_vexillifer",
               "Platanista_gangetica",
               "Pontoporia_blainvillei")

# Run analyses and 
ans <- convrat(phyl = whaletree,
               phendata = pc.data,
               convtips = rivertips)

# Look at output
ans

# Get significance values
# Takes a while to run
pval <- convratsig(phyl = whaletree,
                   phendata = pc.data,
                   convtips = rivertips,
                   nsim = 1000)

# Look at output
pval
