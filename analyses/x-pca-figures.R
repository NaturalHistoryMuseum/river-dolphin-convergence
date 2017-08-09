








#----------------------------
# Plot PCA axes (morphospaces - see "phylomorphospace" for plots)
#----------------------------

#mycolors <- c("lightblue", "black")
#pc1lab <- paste("Principal Component 1 ", "(",
#round(pca.lands$pc.summary$importance[2,1] * 100, 1), "%)", sep = "")
#pc2lab <- paste("Principal Component 2 ", "(",
#round(pca.lands$pc.summary$importance[2,2] * 100, 1), "%)", sep = "")
#pc3lab <- paste("Principal Component 3 ", "(",
#round(pca.lands$pc.summary$importance[2,3] * 100, 1), "%)", sep = "")


# Plot PC1 and PC2
#plot(PC2 ~ PC1, data = pc.scores,
#pch = 21, cex = 2, bg =  mycolors[as.factor(river)],
#xlab = pc1lab, ylab = pc2lab, xlim = c(-0.3, 0.3), ylim = c(-0.3, 0.1), las = 1,cex.lab = 1.5, cex.axis = 1)

#abline(0, 0, lty = 2)
#lines(c(0, 0), c(4, -0.4), lty = 2)


#Plot PC2 and PC3
#plot(PC3 ~ PC2, data = pc.scores,
#pch = 21, cex = 2, bg =  mycolors[as.factor(river)],
#xlab = pc2lab, ylab = pc3lab, xlim = c(-0.3, 0.1), ylim = c(-0.2, 0.2), las = 1,cex.lab = 1.5, cex.axis = 1)

#abline(0, 0, lty = 2)
#lines(c(0, 0), c(4, -0.4), lty = 2)

#Plot PC1 and PC3
#plot(PC3 ~ PC1, data = pc.scores,
#pch = 21, cex = 2, bg =  mycolors[as.factor(river)],
#xlab = pc1lab, ylab = pc3lab, xlim = c(-0.3, 0.3), ylim = c(-0.2, 0.2), las = 1,cex.lab = 1.5, cex.axis = 1)

#abline(0, 0, lty = 2)
#lines(c(0, 0), c(4, -0.4), lty = 2)

#legend("topright", legend = unique(pc.scores$river), pch = 16,  col =  mycolors[unique(pc.scores$river)])

#----------------------------
# Plot thin plate splines
# ----------------------------

# Calculate the mean shape using mshape
meanshape <- mshape(speciesdata$coords)

# Find the mean species
meanspec <- findMeanSpec(speciesdata$coords)
ref <- speciesdata$coords[, , meanspec]

# plot thin plate splines
par (mar = c (0, 0, 0, 0))
plotRefToTarget(ref, pca.lands$pc.shapes$PC1min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC1max)
plotRefToTarget(ref, pca.lands$pc.shapes$PC2min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC2max)
plotRefToTarget(ref, pca.lands$pc.shapes$PC3min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC3max)
plotRefToTarget(ref, pca.lands$pc.shapes$PC4min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC4max)

#----------------------------
# Plot PCA axes (morphospaces - see "phylomorphospace" for plots)
#----------------------------

#mycolors <- c("lightblue", "black")
#pc1lab <- paste("Principal Component 1 ", "(", 
                round(pca.lands$pc.summary$importance[2,1] * 100, 1), "%)", sep = "")
#pc2lab <- paste("Principal Component 2 ", "(", 
                round(pca.lands$pc.summary$importance[2,2] * 100, 1), "%)", sep = "")
#pc3lab <- paste("Principal Component 3 ", "(", 
                round(pca.lands$pc.summary$importance[2,3] * 100, 1), "%)", sep = "")


# Plot PC1 and PC2 
#plot(PC2 ~ PC1, data = pc.scores,
     #pch = 21, cex = 2, bg =  mycolors[as.factor(river)],
     #xlab = pc1lab, ylab = pc2lab, las = 1,cex.lab = 1.5, cex.axis = 1)

#abline(0, 0, lty = 2)
#lines(c(0, 0), c(4, -0.4), lty = 2)


#Plot PC2 and PC3

#plot(PC3 ~ PC2, data = pc.scores,
     #pch = 21, cex = 2, bg =  mycolors[as.factor(river)],
     #xlab = pc2lab, ylab = pc3lab,  las = 1,cex.lab = 1.5, cex.axis = 1)


#abline(0, 0, lty = 2)
#lines(c(0, 0), c(4, -0.4), lty = 2)

#Plot PC1 and PC3 

#plot(PC3 ~ PC1, data = pc.scores,
     #pch = 21, cex = 2, bg =  mycolors[as.factor(river)],
     #xlab = pc1lab, ylab = pc3lab, las = 1,cex.lab = 1.5, cex.axis = 1)

#abline(0, 0, lty = 2)
#lines(c(0, 0), c(4, -0.4), lty = 2)


#legend("topright", legend = unique(pc.scores$river), pch = 16,  col =  mycolors[unique(pc.scores$river)])

#----------------------------
# Plot thin plate splines
# ----------------------------

# Calculate the mean shape using mshape
meanshape <- mshape(speciesdata$coords)

# Find the mean species 
meanspec <- findMeanSpec(speciesdata$coords)
ref <- speciesdata$coords[, , meanspec]

# plot thin plate splines
par (mar = c (0,0,0,0))
plotRefToTarget(ref, pca.lands$pc.shapes$PC1min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC1max)
plotRefToTarget(ref, pca.lands$pc.shapes$PC2min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC2max)
plotRefToTarget(ref, pca.lands$pc.shapes$PC3min)
plotRefToTarget(ref, pca.lands$pc.shapes$PC3max)


1# Make Phylomorphospaces plots for the phylogenetic based section for quantifying convergenc. 

# 1) Edit the phylogeny by Steeman et al (2009), extract the odntocete and prune the trees. 
# 2) Download landmark coords and conduct GPA, group species
#   a) For the cranial (skull) data 

#   b) For the mandible data 

# 3) Conduct a phylogenetic PCA 
# 4) Plot the phylomorphospace

# Donload libraries

library (ape)
library (rgl)
library (geomorph)
library(geiger)
library(maps)
library(phytools)
library(BAMMtools)

# ------------------
# 1) Prune phylogeny
# ------------------

# Load in whale tree
data(whales)

# View the tips of the phylogeny
whales$tip.label

# Extract only the odontocetes
node <- findMRCA(whales, c("Kogia_simus", "Delphinus_delphis"))
odonto <- extract.clade(whales, node)

#Trim the trees 
# Identify your species
# myspecies <- match(odonto$tip.label, ds$Species, nomatch = 0)

# 
myspecies <- match(odonto$tip.label, ds$species, nomatch = 0)
tip <- (odonto$tip.label[which(myspecies == 0)])

pruned.tree<-drop.tip(odonto,tip = tip)
plot(pruned.tree)

# ------------------------------------------
# 2) Download landmark coords and conduct GPA { go to a) cranium //OR// b) mandible }
# ------------------------------------------

# --------------------------------
# a ) For the cranial (skull) data 
# --------------------------------

# set working directory
getwd()
setwd("~/Documents/Projects/River Dolphins 2017/Raw data/Cranium")

# a. read the landmark coordinates into R 

slands <- readland.tps(file = "Version_2_ventral_mandible.TPS", specID =("imageID"), readcurves= TRUE, warnmsg = T)

# delete semi-landmarks which double up with landmarks 
skull <- slands[-c(13,17,18,22,23,25,26,28), , ]

# b. Merge landmark data file with additional information (species, river dolphin/ not river dolphin)

# Fix issues with names missing tiff. 
dimnames(skull)[[3]]  <- gsub("ventralf", "ventral.tiff", dimnames(skull)[[3]])


# Define sliders and read in curves
# mysliders<-define.sliders(skull,8, write.file = TRUE) # crashes my R
curves <- as.matrix(read.csv("curveslide 13.20.39.csv", header = TRUE))

# Read in metadata on specimens
ds <- read.csv("ventral_skull.csv")

ds$Species <- gsub("Grampus_griseus ", "Grampus_griseus", ds$Species)
ds$Species <- gsub("Inia_geoffrensis ", "Inia_geoffrensis", ds$Species)

# SKIP B

# ------------------------
# b) For the mandible data 
# ------------------------

# set working directory
getwd()
setwd("~/Documents/Projects/River Dolphins 2017/Raw data/Mandible")

# Read the landmark coordinates into R 
mlands <- readland.tps(file = "version2_dorsal_mandible.TPS", specID =("imageID"), readcurves= TRUE, warnmsg = T)

# Delete semi-landmarks which double up with landmarks 
mandible <- mlands[-c(9,11,12,14), , ]

# Fix issues with names missing tiff. 
dimnames(mandible)[[3]]  <- gsub("dorsalf", "dorsal.tiff", dimnames(mandible)[[3]])
dimnames(mandible)[[3]] <- gsub("Inia_geoffrensis ", "Inia_geoffrensis",  dimnames(mandible)[[3]])
dimnames(mandible)[[3]]  <- gsub("Grampus_griseus", "Grampus_griseus", dimnames(mandible)[[3]])
dimnames(mandible)[[3]]  <- gsub("Inia_geoffrensis", "Inia_geoffrensis", dimnames(mandible)[[3]])

# Define sliders and read in curves
# mysliders<-define.sliders(mandible, 2, write.file = TRUE) # crashes my R
curves <- as.matrix(read.csv("curveslide.csv", header = TRUE))


# Read in metadata on specimens
ds <- read.csv("Copy of DorsalMandible.csv")

ds$species <- gsub("Grampus_griseus ", "Grampus_griseus", ds$species)
ds$species <- gsub("Inia_geoffrensis ", "Inia_geoffrensis", ds$species)





# ----------------------------------
# General Procrustes alignment (GPA)
# ----------------------------------

# General Procrustes alignment of all scaled coordinates
# gpa <- gpagen(skull, curves, ProcD = TRUE)

# General Procrustes alignment of all scaled coordinates
gpa <- gpagen(mandible, curves, ProcD = TRUE)
#---------------------------------------------
# Group GPA coordinates by species before PCA
#---------------------------------------------

# Sort dataset by the order of specimens in the GPA
mydata <- ds[match(ds$IMAGE, unlist(dimnames(gpa$coords))),]

# Create new list of GPA coords and species info
newx <- list(coords = gpa$coords, species = mydata$Species, river = mydata$River.dolphin)


# Put Coords into a data frame, with species 
x <- two.d.array(newx$coords)

group <- as.factor(ds$species)
means <- (aggregate (x ~ group, FUN = mean))[,-1]
rownames(means)<-levels(group)


# --------------------------------------------

spec <- arrayspecs(means, p = 20, k = 2) #(Skull)


spec <-  arrayspecs(means, p = 10, k = 2) #(Mandible)


### Do this if using a phylogenetic PCA

xx <- two.d.array(spec)

# -----------------------------
# 3) Conduct a phylogenetic PCA 
# -----------------------------
PC <- phyl.pca(pruned.tree, xx)$S

# Or a normal PCA 

pca.lands <- plotTangentSpace(spec,
                              legend = TRUE, label = TRUE)

# ----------------------------
# 4) Plot the phylomorphospace
# ----------------------------

# Create a colour vector (in the order of the phylogeny, in descending order)

colors<-c("deepskyblue3","gray56","gray56","deepskyblue3","deepskyblue3","deepskyblue3","gray56","gray56","gray56","gray56",
          "gray56","gray56","gray56","gray56","gray56","gray56","gray56","gray56","gray56","gray56","gray56","gray56","gray56","gray56","gray56")
names(colors)<-pruned.tree$tip.label
cols<-c(colors[pruned.tree$tip.label],rep("black",pruned.tree$Nnode)) # set the colour of the internal nodes as black
names(cols)<-1:(length(pruned.tree$tip)+pruned.tree$Nnode)

# Plot the phylomorphospace 

# phylomorphospace(pruned.tree,PC[,1:2],control=list(col.node=cols), label = "off")

pca.lands

phylomorphospace(pruned.tree,pca.lands$pc.scores[,1:2],control=list(col.node=cols), label = "off")

phylomorphospace(pruned.tree,pca.lands$pc.scores[,2:3],control=list(col.node=cols), label = "off")


###########

PC <- plotTangentSpace(spec,legend = TRUE, label = TRUE)

PC12<-cbind(-PC$pc.scores[,1],PC$pc.scores[,2])

PC13<-cbind(-PC$pc.scores[,1],PC$pc.scores[,3])

PC23<-cbind(-PC$pc.scores[,2],PC$pc.scores[,3])

phylomorphospace(pruned.tree,PC12,control=list(col.node=cols), label = "off")
phylomorphospace(pruned.tree,PC13,control=list(col.node=cols), label = "off")
phylomorphospace(pruned.tree,PC23,control=list(col.node=cols), label = "off")


     
