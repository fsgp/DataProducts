

# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

#load packages
library(shiny)
library(ggplot2)

#load datasets
df1 <- read.csv("waits.csv", sep = ",")
df2 <- read.csv("waits2.csv",sep = ";")
#waits <- merge(df1,df2, all.x = TRUE, all.y = TRUE)
#clean unused columns
#waits$X = NULL
#waits$AccountID = NULL
#waits$ClientBatchDate = NULL
#waits$DayOfWeek = NULL
#waits$Min = NULL
#remove intermediate datasets from memory
#rm(df1)
#rm(df2)


shinyServer(function(input, output) {
    
    output$waitsByDay <- renderPlot({
        
        if (input$InstanceName == "DBSERVER01"){
            data <- df1
        }
        else
        {
            data <- df2
        }
        
        ggplot(data, aes(x = factor(Day), y = Delta)) +
            geom_bar(stat = "identity", width = .5) +
            facet_wrap( ~ WaitType) +
            labs(x = "By Day", y = "Wait Time Sec Delta") +
            labs(title = paste("Server: ", data$InstanceName))
        
    }, height = 600, width = 900)
    
    output$waitsByHour <- renderPlot({
        
        if (input$InstanceName == "DBSERVER01"){
            data <- df1
        }
        else
        {
            data <- df2
        }
        
        ggplot(data, aes(x = factor(Hour), y = Delta)) +
            geom_bar(stat = "identity", width = .5) +
            facet_wrap( ~ WaitType) +
            labs(x = "By Hour", y = "WaitTimeSec Delta") +
            labs(title = paste("Server: ", data$InstanceName))
        
    }, height = 600, width = 900)
    
    # customize the length drop-down menu; display 5 rows per page by default
    output$mytable1 <- renderDataTable({
        
        if (input$InstanceName == "DBSERVER01"){
            data <- df1
        }
        else
        {
            data <- df2
        }
        
        data
    }, options = list(
        lengthMenu = c(12, 20, 30, 50), pageLength = 12
    ))
    
    
})
