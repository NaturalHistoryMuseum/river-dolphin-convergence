#--------------------------------------------------------------
# Making simplified phylogenies for figures
# Charlotte Page 2017
# Modified by Natalie Cooper 2017
#-------------------------------------
# Load ape
library (ape)

# List the colours to use
colour.list <- c("deepskyblue3", "black", "red1")

#-------------------------------------
# Figure 1a
# Lipotes as a sister group to Inoidea
#-------------------------------------

dolphins1 <- "(Platanistidae, (Ziphidae, ((Lipotidae, (Iniidae,Pontoporidae)),
	         (Delphinidae, (Monodontidae, Phocoenidae)))));"
dolphins.tree1 <- read.tree(text = dolphins1)

# Set up graphical elements of trees
# edge colour is black apart from 6th branch = Lipotes
edge.col1 <- c(rep(colour.list[2], 5), colour.list[3], rep(colour.list[2], 12))
tip.col1 <- colour.list[c(1, 2, 1, 1, 1, 2, 2, 2)]

# Plot tree
plot(dolphins.tree1, adj = 0, label.offset = 0.5, lwd = 2, 
	 tip.color = tip.col1, edge.color = edge.col1, cex = 2)

#-------------------------------------
# Figure 1b
# Lipotes as a sister group to a clade 
# of Inoidea and Delphinida 
#-------------------------------------

dolphins2 <- "(Platanistidae, (Ziphidae, (Lipotidae, ((Iniidae, Pontoporidae),
	         (Delphinidae, (Monodontidae, Phocoenidae))))));"
dolphins.tree2 <- read.tree(text = dolphins2)

# Set up graphical elements of trees
# edge colour is black apart from 5th branch = Lipotes
edge.col2 <- c(rep(colour.list[2], 4), colour.list[3], rep(colour.list[2], 13))
tip.col2 <- colour.list[c(1, 2, 1, 1, 1, 2, 2, 2)]

# Plot tree
plot(dolphins.tree2, adj = 0, label.offset = 0.5, lwd = 2, 
	 tip.color = tip.col2, edge.color = edge.col2, cex = 2)