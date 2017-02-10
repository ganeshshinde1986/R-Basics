set.seed(1678)

x = rnorm(100)
y = rnorm(100)
z = rnorm(100)

#plot() : to create a scatter plot of 2 variables
plot(x,y)

#Adding lables for x and y axis and title for graph
plot(x,y, xlab = "X Index" ,ylab = "Y Index" , main = "X-index Vs Y-index")

#Adding color to graph points
plot(x,y, xlab = "X Index" ,ylab = "Y Index" , main = "X-index Vs Y-index", col = "red")

#pdf() : to save the plot in pdf format
pdf("FirstPlot.pdf")

#jpeg() : to save plot in jpeg format
jpeg("PlotImage.jpeg")

#dev.off() indicates that we are done with creating the plot
dev.off()

#To plot 3-dimensional graphs
#lets create two vectors x and y
x = 1:5
y = x

#outer(): outer products of array x any with dimension c(dim(x),dim(y))
f = outer(x,y,function(x,y)cos(y)/(1+x^2))

#create a contour plot of 3-d , with variables x,y and function f
contour(x,y,f)
contour(x,y,f, nlevels = 45,add=T)

#image() : same as contour but creates a heatmap
image(x,y,f)

#persp() : can also be use to view 3 dimensional plot
persp(x,y,f)

