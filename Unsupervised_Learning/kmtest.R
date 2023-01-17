library(dplyr)
library(tidyr)
library(ggplot2)

# import file
df <- read.csv(file.choose())

# renaming columns
colnames(df) <- c("a")

# prepare data split column into 2
df <- separate(df,col = a, into = c("a","b","c"), sep = "  ")
df <- df[,2:3]

df$b <- as.numeric(df$b)
df$c <- as.numeric(df$c)

xval <- df$b
yval <- df$c

# scatter-plot to see data points
ggplot(df, aes(b,c)) + geom_point(aes(col=b), size=4)

# kmeans function with random.seed for initialization
kclus <- function(b, c, nclus, random.seed=1000) {
  
  set.seed(random.seed)
  # start with random cluster centers
  xcen <- runif(n = nclus, min = min(b), max = max(b))   
  ycen <- runif(n = nclus, min = min(c), max = max(c))
  
  # data points and cluster assignment in "data"
  # cluster coordinates in "clus"
  data <- data.frame(xval = b, yval = c, clus = NA)
  clus <- data.frame(name = 1:nclus, xcen = xcen, ycen = ycen)
  
  finish <- FALSE
  while(finish == FALSE) {
    
    # assign cluster with minimum distance to each data point
    for(i in 1:length(b)) {
      dist <- sqrt((b[i]-clus$xcen)^2 + (c[i]-clus$ycen)^2)
      data$clus[i] <- which.min(dist)
    }
    
    xcen_old <- clus$xcen
    ycen_old <- clus$ycen
    
    # calculate new cluster centers
    for(i in 1:nclus) {
      clus[i,2] <- mean(subset(data$xval, data$clus == i))
      clus[i,3] <- mean(subset(data$yval, data$clus == i))
    }
    
    # stop the loop if there is no change in cluster coordinates
    if(identical(xcen_old, clus$xcen) & identical(ycen_old, clus$ycen)) finish <- TRUE
  }
  data
}


# with default random seed value, it should be able to reproduce the result
cluster <- kclus(xval, yval, 5)
cluster.centers <- aggregate(.~clus, cluster, mean)
ggplot(cluster, aes(xval, yval, color = as.factor(clus))) + 
  geom_point(size=5) + 
  geom_point(data=cluster.centers, aes(xval, yval, col=as.factor(clus)), pch=8, size=5)

#Z score normalization
#m1 <- mean(xval)
#m2 <- mean(yval)
#s1 <- sd(xval)
#s2 <- sd(yval)
#b.z <- (xval-m1)/s1
#c.z <- (xval-m2)/s2

x <- scale(xval)
y <- scale(yval)

cluster <- kclus(x, y, 5)
cluster.centers <- aggregate(.~clus, cluster, mean)
ggplot(cluster, aes(x, y, color = as.factor(clus))) + 
  geom_point(size=5) + 
  geom_point(data=cluster.centers, aes(xval, yval, col=as.factor(clus)), pch=8, size=5)
