# check.packages function: install and load multiple R packages.
# Check to see if packages are installed. Install them if they are not, then load them into the R session.
check.packages <- function(pkg)
{
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}


get.data <- function()
{  
leadsData <- dbConnect(RMariaDB::MariaDB(), user='root', password='', dbname='dw_eigen_lead', host='localhost')
query <- "select * from dw_eigen_lead.dw_leads_store"
rleadsData <- dbSendQuery(leadsData, query)
rData <- dbFetch(rleadsData,n=-1)
actualData <- rData[!duplicated(rData), ]
dbDisconnect(leadsData)
returnDat <- actualData[,c(26,1:8,30,9:25,27:29)]
return(returnDat)
}

get.profile <- function(finputData)
{
  desc_finputdata <- describe(finputData,size = 'normalsize',exclude.missing=FALSE)
  
  detailed_file <- lapply(desc_finputdata, function(x) {
    x[sapply(x, is.null)] <- NA
    unlist(x,recursive = TRUE)
  })
  
  dfDetailedProfile <-as.data.frame(do.call("cbind", detailed_file))
  transposDetailProfile <- t(dfDetailedProfile)
  filteredDetails <- transposDetailProfile[,c(1,4,5,6)]
  
  
  rowcount = nrow(finputData)
  colcount = ncol(finputData)
  population = 0
  
  #fieldType <- sapply(finputData, typeof)
  
  for(i in 1:colcount)
  {
    x <- ((rowcount-as.numeric(filteredDetails[i,3]))/rowcount)*100
    population[i] <- as.numeric(round(x,2))
  }
  
  finalOutput = cbind(filteredDetails[,1:3],as.data.frame(population),filteredDetails[,4])
  
  colnames(finalOutput) <- c("Field_Name","Population_Count","Missing_Count","Population_Percentage","No_Of_Distinct_Values")
  rownames(finalOutput) <- NULL
  
  
  return(finalOutput)
  
}


