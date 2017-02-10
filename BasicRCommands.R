#Function c() to create vecor
vec1 <- c(2,4,5)
vec1
vec2 <- c(3,6,7)
vec2

#length() : Function to calculate length of vector
length(vec1)

#Vectors of same length can be added together
vec3 <- vec1 + vec2
vec3

#ls() : To list all objects created in R
ls()

#rm() : To remove object created in R
rm(vec3)

#rm(list = ls()) : To remove all the objects in repository once
rm(list = ls())

#matrix(): to create matrix of numbers
mat1 <- matrix(data = c(1,2,3,4,5,6), nrow = 2, ncol = 3)
mat1

#above matrix() function can also be used as below
mat2 <- matrix(c(1,2,1,2,1,2),3,2)
mat2

#By Default R craetes matrix by filling data by column.
#using byrow = TRUE we can fill data by row
romMat1 <- matrix(data = c(4,5,6,7,8,9),nrow = 2, ncol = 3, byrow = TRUE)
romMat1

#SQRT() returns square root of each element in matrix
sqrt(romMat1)

#rnorm(): function creates vector of random normal nunbers
#By default rnorm function creates vector of random numbers
#with mean 0 and sd = 1
normVec1 <- rnorm(50)

#rnorm(): we can also generate vector of random numbers
#specifying the mean and standard deviation
normVec2 <- rnorm(50,mean=10,sd=5)

#cor() : function is used to calculate correlation between two vectors
cor(normVec1,normVec2)

#Set.seed function is used to reproduce exact same random numbers again
#Set.seed function takes any arbitary integer number as argument
set.seed(1203)

#mean() : to calculate mean of vector of numbers
mean(normVec1)

#var() : to calculate variance of vector of numbers
var(normVec1)

#sd() : to calculate standard deviation of 
sd(normVec1)

#seq() : can be use to create sequence of numbers from
#starting number a to end number b, by default incement will be by 1
seq1 <- seq(1,10)

#seq() : by specifying 3rd parameter we can add the gap interval between numbers
seq2 <- seq(1,11,2)

#Seq() : by sepcifying length of sequence we can divide the interval in equal parts
seq3 <- seq(1,2,length = 10)
seq3

#Typing a:b is shorthand of using seq
seq4 <- 1:50
seq5 <- 1:20:5 #only 5 elements are used of sequence of 1 to 20 numbers.


