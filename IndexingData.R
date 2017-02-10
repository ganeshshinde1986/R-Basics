#create a square matrix A
A<-matrix(1:16,4,4)
A
#selecting element from 2nd row and 3rd column
A[2,3]

#selecting multiple rows and multiple columns
A[c(1,3),c(2,4)]

#Selecting series of rows and columns
A[1:2,2:4]

# all row elements of selected rows
A[1:2,]

#All columns elements of selected columns
A[,3:4]

#R treats single row or column of matrix as vector
A[1,]
A[,2]

#Negative indices denote that keep all the rows or columns other 
#than mention in indices
A[-c(1,2),]
A[,-c(3,4)]
A[-1,-2]

#dim() : outputs no. of rows followed by no. of columns
dim(A)
