source("helper.R")
source("global.R")

#Loading all required package using helper function check.packages.
packages.needed <- c("shiny","shinydashboard","httr","jsonlite","xlsx","dplyr","DT","Hmisc","rsconnect")
check.packages(packages.needed)


# Define UI ----
ui <- fluidPage(
titlePanel("Eigenlytics Demo Application"),

sidebarLayout(
  
  sidebarPanel(
    fileInput("file","Upload the file"),
    h5("Max file size to upload is 50 MB"),
    radioButtons("sep","Seperator",choices = c(Comma = ',', Pipe = "|" ,Period = ".", Tilde = "~", Minus = "-")),
    checkboxInput("header","Header?")
    #textInput("txtInput","Enter the text here")
  ),
  
  mainPanel(
    tabsetPanel(type = "tab",
    #tableOutput("inputFile")
    tabPanel("Data",
    br(),
    DT::dataTableOutput("inputFile")),
    
    tabPanel("Summary",
             br(),
             
             fluidRow(
             column(6,
             #h5("Total Number Of Records:",align="left"),
             textOutput("rowCount")),
             column(6,
             #h5("Total Number of Fields:",align ="left"),
             textOutput("colCount"))
             ),
             #br(),
             hr(),
             DT::dataTableOutput("profile")
             ),
    
    tabPanel("Field Profiles",
             br(),
             fluidRow(
               column(6,
                      selectInput('selFieldName', 'Select a Field Name:', ""))
             ),
             fluidRow(
               column(6,
                      #h5("Total Number Of Records:",align="left"),
                      textOutput("popCount")),
               column(6,
                      #h5("Total Number of Fields:",align ="left"),
                      textOutput("missingCount"))
             ),
             fluidRow(
               column(6,
                      #h5("Total Number Of Records:",align="left"),
                      textOutput("popPercent")),
               column(6,
                      #h5("Total Number of Fields:",align ="left"),
                      textOutput("distinctValues"))
             ),
             hr(),
             DT::dataTableOutput("detailProfile")
             )
    

    #paste("You have entered"),
    #textOutput("txtOutput")
    )
    
  )
)
) # dashboardBody ends here


# Define server logic ----
server <- function(input, output,session) {
  
  #output$inputFile <- renderTable(
    loadedData <- reactive( {
      file_to_read = input$file
      if(is.null(file_to_read)){
        return(NULL)
      }
      read.csv(file_to_read$datapath,sep = input$sep ,header = input$header )
    })

      #profileFile <- get.profile(inputFile)
      
      #read.table(file_to_read$datapath,sep = input$sep ,header = input$header)
    #extensions = "Buttons" , options = list(scrollX = TRUE,dom="Bflrtip", buttons = list("copy","pdf","save","excel","print"))
  
  output$inputFile <- DT::renderDataTable(loadedData(),
  extensions = 'Buttons',  
  options = list(scrollX = TRUE,dom = 'Blfrtip',buttons = list(buttons =c('csv','excel'),text = 'Download'),lengthMenu = list(c(10,50,100,-1),c(10,50,100,'All'))),
  rownames = FALSE,
  filter = 'top')
  
  profileData <- reactive({
    fileData <- loadedData()
    if(is.null(fileData)){
      return(NULL)
    }
    else{
      
      output$rowCount <- renderText({
        paste("Total Number Of Records:",nrow(loadedData()))
      })
      
      output$colCount <- renderText({
        paste("Total Number Of Fields:",ncol(loadedData()))
      })
      
      
      return(get.profile(fileData))
    }
    
  })
  
  output$profile <- DT::renderDataTable(profileData(),
                                         extensions = 'Buttons',  
                                         options = list(scrollX = TRUE,dom = 'Blfrtip',buttons = list(buttons =c('csv','excel'),text = 'Download'),lengthMenu = list(c(10,50,100,-1),c(10,50,100,'All'))),
                                         rownames = FALSE,
                                         filter = 'top')
  
  outVar <- reactive({
    mydata <- loadedData()
    names(mydata)
  })
  
  observe({
    updateSelectInput(session, "selFieldName",
                      choices = outVar()
    )}
    
    #fldProfile <- reactive({
    #selField <- input$selFieldName
    
    
    #})
  
)
  

  }
  
  
  
  #output$txtOutput <- renderText({
   # paste(input$txtInput)
  #})



# Run the app ----
shinyApp(ui = ui, server = server)


