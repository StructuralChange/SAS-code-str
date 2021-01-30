
library(RColorBrewer)

rm(list=ls())
setwd("Q:/= IRI data research/Diebold Mariana Test/results data")

 

 

overall_r_adl4_versus_r_ad4_ew <- read.csv("overall_r_adl4_versus_r_ad4_ew.csv")
overall_r_adl4_versus_r_ad4_ic <- read.csv("overall_r_adl4_versus_r_ad4_ic.csv")
overall_r_adl4_versus_r_ewc_ic <- read.csv("overall_r_adl4_versus_r_ewc_ic.csv")
 

horizon_parm <- 8

overall_r_adl4_versus_r_ad4_ew <- overall_r_adl4_versus_r_ad4_ew[overall_r_adl4_versus_r_ad4_ew$horizon <=horizon_parm,]
overall_r_adl4_versus_r_ad4_ic <- overall_r_adl4_versus_r_ad4_ic[overall_r_adl4_versus_r_ad4_ic$horizon <=horizon_parm,]
overall_r_adl4_versus_r_ewc_ic <- overall_r_adl4_versus_r_ewc_ic[overall_r_adl4_versus_r_ewc_ic$horizon <=horizon_parm,]
 
category   <- unlist(c(overall_r_adl4_versus_r_ewc_ic["category"]), use.names=FALSE) #category
sku   <- unlist(c(overall_r_adl4_versus_r_ewc_ic["sku"]), use.names=FALSE) #category
 
e3  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["q_0"]), use.names=FALSE)   #3 adl4
 
e6  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["q_1"]), use.names=FALSE) #6 ad4_ew
e7  <- unlist(c(overall_r_adl4_versus_r_ad4_ic["q_1"]), use.names=FALSE) #7 ad4_ic

e8  <- unlist(c(overall_r_adl4_versus_r_ewc_ic["q_1"]), use.names=FALSE) #8 ewc_ic

improve_ad4_ew_adl4 <- e6/e3
improve_ad4_ic_adl4 <- e7/e3
improve_ew_ic_adl4  <- e8/e3


m <- cbind(  improve_ad4_ew_adl4, improve_ad4_ic_adl4, improve_ew_ic_adl4)


m <- as.matrix(m[,ncol(m):1])

 



# load the data and convert to a matrix
#p <- read.csv("probly.csv")
#m <- as.matrix(p[,ncol(p):1])

# create some random data for jitter
r <-  (matrix(runif(nrow(m)*ncol(m)), nrow=nrow(m), ncol=ncol(m)) / 2) - 0.25

# create colours and colour matrix (for points)
cols  <- colorRampPalette(brewer.pal(12, "Set3"), alpha=TRUE)(ncol(m))
colsm <-matrix(rep(cols, each=nrow(m)), ncol=ncol(m))

# get the greys (stolen from https://github.com/zonination/perceptions/blob/master/percept.R)
palette <- brewer.pal("Greys", n=9)
color.background = palette[2]
color.grid.major = palette[5]

# set graphical area
par(bty="n", bg=palette[2], mar=c(5,8,3,1))

# plot initial boxplot
boxplot(m~col(m), horizontal=TRUE, outline=FALSE, lty=1, staplewex=0, boxwex=0.8, boxlwd=1, medlwd=1, col=cols, xaxt="n", yaxt="n")
 



# plot gridlines
for (i in seq(0,100,by=10)) {
	lines(c(i,i), c(0,20), col=palette[4])
}

for (i in seq(1,6,by=1)) {
	lines(c(-5,105), c(i,i), col=palette[4])
}

# plot points
points(m, col(m)+r, col=colsm, pch=16)

# overlay boxplot
boxplot(m~col(m), horizontal=TRUE, outline=FALSE, lty=1, staplewex=0, boxwex=0.8, boxlwd=1, medlwd=1, col=cols, add=TRUE, xaxt="n", yaxt="n")

# add axes and title
axis(side=1, at=seq(0,100,by=10), col.axis=palette[7], cex.axis=0.8, lty=0, tick=NA, line=-1)
axis(side=1, at=50, labels="Assigned Probability %", lty=0, tick=NA, col.axis=palette[7])
axis(side=2, at=1:17, col.axis=palette[7], cex.axis=0.8, lty=0, tick=NA, labels=colnames(m), las=2)
axis(side=2, at=17/2, labels="Phrase", col.axis=palette[7], lty=0, tick=NA, las=3, line=6)
title("Perceptions of Probability")
