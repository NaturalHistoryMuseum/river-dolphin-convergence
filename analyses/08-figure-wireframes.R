#--------------------------------------------------------------
# Wire frame plots of species mean PCA data
# Charlotte Page 2017
# Modified by Natalie Cooper 2017
#-------------------------------------
# Setup
#-------------------------------------
# Setwd as the folder for this project
# or open a new project there

# Load libraries
library(rgl)
library(geomorph)

#-------------
# A: CRANIA
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

#--------------------------------------------
# STEP 2: Principal components analysis (PCA)
# and wire fram plots
#--------------------------------------------
# PCA 
pca.lands <- plotTangentSpace(species.data$coords, 
                              groups = as.factor(species.data$river),
                              legend = TRUE, label = TRUE)

# Calculate the mean shape using mshape
meanshape <- mshape(species.data$coords)

# Find the mean species
meanspec <- findMeanSpec(species.data$coords)
ref <- species.data$coords[, , meanspec]

# Set up graphical parameters
par(mar = c(0, 0, 0, 0))
par(mfrow = c(4, 2))

# Plot thin plate splines
plotRefToTarget(ref, pca.lands$pc.shapes$PC1min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC1max)
plotRefToTarget(ref, pca.lands$pc.shapes$PC2min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC2max)
plotRefToTarget(ref, pca.lands$pc.shapes$PC3min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC3max)
plotRefToTarget(ref, pca.lands$pc.shapes$PC4min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC4max)

#-------------
# B: MANDIBLES
#-------------
# A: CRANIA
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
mand <- readland.tps(file = "data/dolphin-mandibles.TPS",
                       specID = "ID",
                       readcurves = TRUE,
                       warnmsg = TRUE)

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
gpa <- gpagen(mand, curves, ProcD = TRUE)

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

#--------------------------------------------
# STEP 2: Principal components analysis (PCA)
# and wire fram plots
#--------------------------------------------
# PCA 
pca.lands <- plotTangentSpace(species.data$coords, 
                              groups = as.factor(species.data$river),
                              legend = TRUE, label = TRUE)

# Calculate the mean shape using mshape
meanshape <- mshape(species.data$coords)

# Find the mean species
meanspec <- findMeanSpec(species.data$coords)
ref <- species.data$coords[, , meanspec]

# Set up graphical parameters
par(mar = c(0, 0, 0, 0))
par(mfrow = c(3, 2))

# Plot thin plate splines
plotRefToTarget(ref, pca.lands$pc.shapes$PC1min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC1max)
plotRefToTarget(ref, pca.lands$pc.shapes$PC2min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC2max)
plotRefToTarget(ref, pca.lands$pc.shapes$PC3min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC3max)
