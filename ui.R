library(shiny)

shinyUI(fluidPage(title = 'Database Waits Times',
                  
                  #Application title
                  titlePanel("Database Waits Times - By Hour and Day"),
                  
                  sidebarLayout(
                      sidebarPanel(
                          HTML("Please select a server from the dropdown. You can switch between different views of the data by using the tabs below.<br><br>"),
                          selectInput(
                          "InstanceName",
                          "InstanceName:",
                          c(list("DBSERVER01","DBSERVER02","DBSERVER03"))
                      ), width = "50%"),
                      mainPanel(
                          tabsetPanel(
                          id = 'dataset',
                          tabPanel('Waits by Day', plotOutput("waitsByDay",  width = "100%")),
                          tabPanel('Waits by Hour', plotOutput("waitsByHour",  width = "100%")),
                          tabPanel('Data', dataTableOutput('mytable1'))
                          
                      ))
                  )))
