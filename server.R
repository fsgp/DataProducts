#load packages
library(shiny)
library(ggplot2)

#load datasets
df1 <- read.csv("waits.csv", sep = ",")
df2 <- read.csv("waits2.csv",sep = ",")
df3 <- read.csv("waits3.csv",sep = ",")

shinyServer(function(input, output) {
    
    output$waitsByDay <- renderPlot({
        
        data = GetDataFrame(input$InstanceName)

        ggplot(data, aes(x = factor(Day), y = Delta)) +
            geom_bar(stat = "identity", width = .5) +
            facet_wrap( ~ WaitType) +
            labs(x = "By Day", y = "Wait Time Sec Delta") +
            labs(title = paste("Server: ", data$InstanceName))
        
    }, height = 600, width = 900)
    
    output$waitsByHour <- renderPlot({
        
        data = GetDataFrame(input$InstanceName)

        ggplot(data, aes(x = factor(Hour), y = Delta)) +
            geom_bar(stat = "identity", width = .5) +
            facet_wrap( ~ WaitType) +
            labs(x = "By Hour", y = "WaitTimeSec Delta") +
            labs(title = paste("Server: ", data$InstanceName))
        
    }, height = 600, width = 900)
    
    # customize the length drop-down menu; display 5 rows per page by default
    output$mytable1 <- renderDataTable({
        
        data = GetDataFrame(input$InstanceName)

        data
    }, options = list(
        lengthMenu = c(12, 20, 30, 50), pageLength = 12
    ))
    
    GetDataFrame <- function(instanceName)
    {
        if (instanceName == "DBSERVER01"){
            data <- df1
        }
        if (instanceName == "DBSERVER02"){
            data <- df2
        }
        if (instanceName == "DBSERVER03"){
            data <- df3
        }
        
        return(data)
    }
    
})
