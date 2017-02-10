#read.table() : to read a file.
#To treat first records as header give header = TRUE
#to mention the separator use property sep
oliveData <- read.table("olive.csv", header = TRUE, sep = ",")

#fix() is used to view data in spreadsheet like window
fix(oliveData)

#na.string() parameter helps to identify null values or missing elements.
oliveData2 <- read.table("olive.csv", header = TRUE, sep = ",",na.strings = "1")

#read.csv = used to load data in csv format easily
oliveData3 <- read.csv("olive.csv", header = TRUE)

#Dimensions of data loaded
dim(oliveData2)

#na.omit function removes data with null or missing values/NA values
oliveData2 <- na.omit(oliveData2)

#names() : to check variable names
names(oliveData3)

dev.new()

#Plotting a scatter plot for 2 numerical variables
plot(oliveData$palmitic,oliveData$palmitoleic)

#attach : use to make variables in data frame available by name
attach(oliveData)
plot(palmitic,palmitoleic)

#as.factor() function converts quantitative variables into qualitative variables
region <- as.factor(region)

plot(palmitic,palmitoleic)
plot(palmitic,palmitoleic, col = "red")
plot(palmitic,palmitoleic, col = "red", xlab = "palmitic", ylab = "palmitoleic")

#Hist function creates a histogram
hist(palmitoleic)

#breaks property adds the no. of breaks in histogram
hist(palmitoleic, breaks = 15)

#pairs() : creates scatter plot pairs for all variables in dataset
pairs(oliveData)

#Identify function is use to identify particular point on graph
point = c(3,4)
plot(palmitic,palmitoleic)
identify(palmitic,palmitoleic,point)

#for selective scatter plot creation of vaiables pairs can be used as follows
pairs(~region+area+X,oliveData)

#Summary function provides numeric summary of each variables in data
summary(oliveData)
summary(area)
