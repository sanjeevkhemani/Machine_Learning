library(dplyr)
library(tidyr)
library(ggplot2)

# import file
df <- read.csv(file.choose())

# Question 1
# prepare data split column into 2
# df <- separate(df,col = a, into = c("a","b","c"), sep = "  ")
# df <- df[,2:3]
# 
# df$b <- as.numeric(df$b)
# df$c <- as.numeric(df$c)
# 
# xval <- df$b
# yval <- df$c

# Question 2
# prepare data into 5 columns
colnames(df) <- c("a", "b", "c", "d", "e")

# leaving the 5th column out for clustering
# df<- df[,1:4]

df$a <- as.numeric(df$a)
df$b <- as.numeric(df$b)
df$c <- as.numeric(df$c)
df$d <- as.numeric(df$d)

aval <- df$a
bval <- df$b
xval <- df$c
yval <- df$d

# scatter-plot to see data points
ggplot(df, aes(a,b,c,d)) + geom_point(aes(col=e), size=4)

# kmeans function with random.seed for initialization
kclus <- function(a, b, c, d, nclus, random.seed=1000) {
  
  set.seed(random.seed)
  # start with random cluster centers
  acen <- runif(n = nclus, min = min(a), max = max(a))   
  bcen <- runif(n = nclus, min = min(b), max = max(b))
  xcen <- runif(n = nclus, min = min(c), max = max(c))   
  ycen <- runif(n = nclus, min = min(d), max = max(d))
  
  # data points and cluster assignment in "data"
  # cluster coordinates in "clus"
  data <- data.frame(aval = a, bval = b, xval = c, yval = d, clus = NA)
  clus <- data.frame(name = 1:nclus, acen = acen, bcen = bcen, xcen = xcen, ycen = ycen)
  
  finish <- FALSE
  while(finish == FALSE) {
    
    # assign cluster with minimum distance to each data point
    for(i in 1:length(a)) {
      dist <- sqrt((a[i]-clus$acen)^2 + (b[i]-clus$bcen)^2 +
                     (c[i]-clus$xcen)^2 + (d[i]-clus$ycen)^2)
      data$clus[i] <- which.min(dist)
    }
    
    acen_old <- clus$acen
    bcen_old <- clus$bcen
    xcen_old <- clus$xcen
    ycen_old <- clus$ycen
    
    # calculate new cluster centers
    for(i in 1:nclus) {
      clus[i,2] <- mean(subset(data$aval, data$clus == i))
      clus[i,3] <- mean(subset(data$bval, data$clus == i))
      clus[i,4] <- mean(subset(data$xval, data$clus == i))
      clus[i,5] <- mean(subset(data$yval, data$clus == i))
    }
    
    # stop the loop if there is no change in cluster coordinates
    if(identical(acen_old, clus$acen) & identical(bcen_old, clus$bcen) &
       identical(ycen_old, clus$xcen) & identical(ycen_old, clus$ycen)) finish <- TRUE
  }
  data
}


# with default random seed value, it should be able to reproduce the result
cluster <- kclus(aval, bval, xval, yval, 3)
cluster.centers <- aggregate(.~clus, cluster, mean)
ggplot(cluster, aes(aval, bval, xval, yval, color = as.factor(clus))) + 
  geom_point(size=2) + 
  geom_point(data=cluster.centers, aes(aval, bval, xval, yval, col=as.factor(clus)), pch=8, size=5)

#Z score normalization
#m1 <- mean(xval)
#m2 <- mean(yval)
#s1 <- sd(xval)
#s2 <- sd(yval)
#b.z <- (xval-m1)/s1
#c.z <- (xval-m2)/s2

# x <- scale(xval)
# y <- scale(yval)

# cluster <- kclus(x, y, 3)
# cluster.centers <- aggregate(.~clus, cluster, mean)
# ggplot(cluster, aes(x, y, color = as.factor(clus))) + 
#   geom_point(size=2) + 
#   geom_point(data=cluster.centers, aes(xval, yval, col=as.factor(clus)), pch=8, size=5)
