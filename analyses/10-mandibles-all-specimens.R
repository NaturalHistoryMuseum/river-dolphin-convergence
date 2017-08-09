#--------------------------------------------------------------
# Geometric morphometric analyses of all specimens mandible data
# Charlotte Page 2017
# Modified by Natalie Cooper 2017

# STEP 1: Input and ordinate shape data
# Input coordinate data
# GPA (Generalised Procrustes Analysis)

# STEP 2: Tests for convergence 
# Procrustes ANOVA on GPA coordinates
# PCA to explore shape variation
# ANOVA on first three principal components (PCs) individually 
# to see which PCs are significantly different

#-------------------------------------
# Setup
#-------------------------------------
# Setwd as the folder for this project
# or open a new project there

# Load libraries
library(rgl)
library(geomorph)

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
# mysliders <- define.sliders(mandible, 2, write.file = TRUE) 
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

# Sort dataset by the order of specimens in the GPA
mydata <- ds[match(dimnames(gpa$coords)[[3]], ds$image), ]

# Put it all together for further analyses
specimen.data <- list(coords = gpa$coords,
                      specimen = mydata$image,
                      species = mydata$species,
                      river = mydata$river)

#------------------------------------------------------
# Run MANOVAs on GPA coords 
# to determine if river dolphins are significantly 
# different to other dolphins
#-------------------------------------------------------
# Create geomorph dataframe for MANOVA
gdf <- geomorph.data.frame(coords = specimen.data$coords,
                           group = specimen.data$river)

# GPA MANOVA with randomize residuals RRPP method
manova <- procD.lm(coords ~ group, data = gdf, iter =  999, RRPP = TRUE) 
summary(manova)

#------------------------------------
# Principal components analysis (PCA)
#------------------------------------
# PCA 
pca.lands <- plotTangentSpace(specimen.data$coords, 
                              groups = as.factor(specimen.data$river),
                              legend = TRUE, label = TRUE)

# Summary of variance associated with each PCA axis
pca.lands$pc.summary

# PC scores for each specimen
pca.lands$pc.scores

# Show barplot of variance explained by each PC
barplot(pca.lands$pc.summary$sdev^2 / 
        sum(pca.lands$pc.summary$sdev^2))

# Eigenvectors
pca.lands$rotation

# Create dataframe for further analysis
pc.scores <- data.frame(pca.lands$pc.scores,
                        species = specimen.data$species,
                        river = specimen.data$river)

#--------------------------------------------------------
# ANOVAs to test whether individual PCs are significantly 
# different in river dolphins and other dolphins
#--------------------------------------------------------
# PC1
model1 <- lm(PC1 ~ river, data = pc.scores)
anova(model1)
summary(model1)

# PC2
model2 <- lm(PC2 ~ river, data = pc.scores)
anova(model2)
summary(model2)

# PC3
model3 <- lm(PC3 ~ river, data = pc.scores)
anova(model3)
summary(model3)

# PC4
model4 <- lm(PC4 ~ river, data = pc.scores)
anova(model4)
summary(model4)

# PC5
model5 <- lm(PC5 ~ river, data = pc.scores)
anova(model5)
summary(model5)