#-----------------------------------------------------------------
# Calculate 'repeatability' in replicate attempts for both datasets.
# Just uses replicated Tursiops dataset
# Method following that outlined on 
# github.com/geomorphR/geomorph/wiki/Examining-replicate-error
# Charlotte Page 2017
# Modified by Natalie Cooper 2017

# A: CRANIA DATA
# STEP 1: Input and ordinate shape data
# Input coordinate data
# GPA (Generalised Procrustes Analysis)

# STEP 2: Calculate repeatability
# Procrustes ANOVA on GPA coordinates

# B: MANDIBLES DATA
# STEP 1: Input and ordinate shape data
# Input coordinate data
# GPA (Generalised Procrustes Analysis)

# STEP 2: Calculate repeatability
# Procrustes ANOVA on GPA coordinates

#-------------------------------------
# Setup
#-------------------------------------
# Setwd as the folder for this project
# or open a new project there

# Load libraries
library(rgl)
library(geomorph)

#----------------------------------------------
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
skull <- readland.tps(file = "data/tursiops-crania.TPS",
                       specID = "ID",
                       readcurves = TRUE,
                       warnmsg = TRUE)

# Read in curves - these are the same as for all the data
curves <- as.matrix(read.csv("data/dolphin-crania-curves.csv", header = TRUE))

# General Procrustes alignment (GPA)
# of all scaled coordinates
gpa <- gpagen(skull, curves, ProcD = TRUE)

#--------------------------------------------------
# Procrustes ANOVA and calculation of repeatability
#--------------------------------------------------
# Create vector labeling each individual specimen
# 1 - 3, three of each
individual <- as.factor(rep(c(rep(1, 3), rep(2, 3), rep(3, 3)), 3))

# Create vector labeling each replicate of each specimen
# 9 specimens, three of each
replicate <- as.factor(rep(1:3, 9))

# Repeatability for cranium
rep.aov  <- procD.lm(gpa$coords ~ individual:replicate)

# Save the ANOVA table from above
aov.results <- rep.aov$aov.table 

# Calculate repeatability (see link above for equation)
((aov.results$MS[1] - aov.results$MS[2])/2) / 
(aov.results$MS[2] + ((aov.results$MS[1] - aov.results$MS[2])/2))

# 0.9132938

#----------------------------------------------
# B: MANDIBLES
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
mandible <- readland.tps(file = "data/tursiops-mandibles.TPS",
                       specID = "ID",
                       readcurves = TRUE,
                       warnmsg = TRUE)

# Read in curves  - these are the same as for all the data
mand.curves <- as.matrix(read.csv("data/dolphin-mandibles-curves.csv", header = TRUE))

# General Procrustes alignment (GPA)
# of all scaled coordinates
gpa <- gpagen(mandible, mand.curves, ProcD = TRUE)

#--------------------------------------------------
# Procrustes ANOVA and calculation of repeatability
#--------------------------------------------------
# Create vector labeling each individual specimen
# 1 - 3, three of each
individual <- as.factor(rep(c(rep(1, 3), rep(2, 3), rep(3, 3)), 3))

# Create vector labeling each replicate of each specimen
# 9 specimens, three of each
replicate <- as.factor(rep(1:3, 9))

# Repeatability for cranium
rep.aov  <- procD.lm(gpa$coords ~ individual:replicate)

# Save the ANOVA table from above
aov.results <- rep.aov$aov.table 

# Calculate repeatability (see link above for equation)
((aov.results$MS[1] - aov.results$MS[2])/2) / 
(aov.results$MS[2] + ((aov.results$MS[1] - aov.results$MS[2])/2))

# 0.9309665