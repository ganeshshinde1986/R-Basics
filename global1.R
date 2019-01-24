options(shiny.maxRequestSize = 50*1024^2)

jsfunc <- "function() {arrIndexes=[1,3,4,8,12]; $('#tbl tbody tr').filter(function(index) {return arrIndexes.indexOf(index) > -1;}).click()}"

