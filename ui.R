

# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(title = 'Database Waits Times',
                  
                  #Application title
                  # titlePanel("Database Waits Times - By Hour and Day"),
                  
                  sidebarLayout(
                      sidebarPanel(selectInput(
                          "InstanceName",
                          "InstanceName:",
                          c(list("DBSERVER01","DBSERVER02"))
                      ), width = "50%"),
                      mainPanel(tabsetPanel(
                          id = 'dataset',
                          tabPanel('Waits by Day', plotOutput("waitsByDay",  width = "100%")),
                          tabPanel('Waits by Hour', plotOutput("waitsByHour",  width = "100%")),
                          tabPanel('Data', dataTableOutput('mytable1'))
                          
                      ))
                  )))
