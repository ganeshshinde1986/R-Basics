#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

source("helper.R")
source("global.R")

#Loading all required package using helper function check.packages.
packages.needed <- c("shiny","shinydashboard","httr","jsonlite","xlsx","dplyr",
                     "DT","Hmisc","rsconnect","RMariaDB","plotly")

check.packages(packages.needed)


ui <- dashboardPage( skin = "blue",
  
   # Application title
  dashboardHeader(title = "Lead Management"),
   
  dashboardSidebar( 
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Lead Allocation", tabName = "ldAllocate", icon = icon("address-card")),
      menuItem("Upload File", tabName = "ldUploadFile", icon = icon("upload"))
    )),
  
  dashboardBody( 
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              
              fluidRow(
                # A static infoBox
                valueBoxOutput("TotalLeads"),
                # Dynamic infoBoxes
                valueBoxOutput("ConvertedLeads"),
                valueBoxOutput("OpenLeads")
              ),#fluid row ends here
              
              
              fluidRow(
                box(plotOutput("histogram")),
                
                box(
                  fluidRow(
                  valueBoxOutput("HotLeads")),
                  fluidRow(
                  valueBoxOutput("WarmLeads")),
                  fluidRow(
                  valueBoxOutput("ColdLeads"))
                )
              )
              
            
    ),
    
    
    tabItem(tabName = "ldAllocate",
            
            fluidRow(
              
              column(10),
              column(2,
            submitButton("Allocate Leads"))
            ),
            br(),
      
            hr(),
            DT::dataTableOutput("leadData")
            ),
    
    
    tabItem(tabName = "ldUploadFile",
            
            fluidRow(
              
              column(4,
            fileInput("file","Upload the file"),
            h5("Max file size to upload is 50 MB")),
            column(4,
            selectInput("selInput",label = "Select The Source System",
                        c("ABC Source System - CSV" = "csvSource","XYZ System - Excel" = "exlSource"))
                   ),
            column(4,
                   br(),submitButton("Add File to Lead Store"))
            ),
            
            fluidRow(
              tabBox()
            )
            
            )#fluid row ends here
            
            
    )# tab item ends here
  ) # tab items ends here
  
    )# tab items ends here
# dashboardBody ends here


# Define server logic required to draw a histogram
server <- function(input, output,session) {

    fetchData <- reactive( {
    allLeads = get.data()
    if(nrow(allLeads)==0){
      return(NULL)}
      else{return(allLeads)}
    
  })  
    
    
    valueCnt <- get.data()
    assignedLeads <- valueCnt[which(valueCnt$Assigned_Agent_Code < 99999999),]
    
    output$TotalLeads <- renderValueBox({
      valueBox(
      paste0(nrow(valueCnt)),"Total Leads",icon = icon("list")
      )
    }
    )
    output$ConvertedLeads <- renderValueBox({
      valueBox(
        paste0(nrow(assignedLeads)),"Assigned Leads",icon = icon("thumbs-up")
      )})
    
    output$OpenLeads <- renderValueBox({
      valueBox(
        paste0(nrow(valueCnt)- nrow(assignedLeads)),"Open Leads",icon = icon("tasks")
      )})
    
    
    
    output$HotLeads <- renderValueBox({
      valueBox(
        paste0(nrow(valueCnt[valueCnt$lead_score==90,])),"Hot Leads",icon = icon("fire")
      )
    }
    )
    output$WarmLeads <- renderValueBox({
      valueBox(
        paste0(nrow(valueCnt[valueCnt$lead_score==75,])),"Warm Leads",icon = icon("bandcamp")
      )})
    
    output$ColdLeads <- renderValueBox({
      valueBox(
        paste0(nrow(valueCnt[valueCnt$lead_score==60,])),"Cold Leads",icon = icon("cloud")
      )})
    
    #valueBoxOutput$OpenLeads
    output$histogram <- renderPlot({hist(valueCnt$lead_score, main = "Lead Qulification Distribution",col = "sky blue" ,border = "sky blue",
                                         xlab = "Lead Qualiification Score", ylab = "Frequncy")})
    
    
    output$leadData <- DT::renderDataTable(fetchData(),
                                            extensions = 'Buttons', 
                                            selection = "multiple",
                                            options = list(scrollX = TRUE,dom = 'Blfrtip',buttons = list(buttons =c('csv','excel'),text = 'Download'),lengthMenu = list(c(10,50,100,-1),c(10,50,100,'All'))),
                                            rownames = FALSE,
                                            filter = 'top')

  
}

# Run the application 
shinyApp(ui = ui, server = server)

