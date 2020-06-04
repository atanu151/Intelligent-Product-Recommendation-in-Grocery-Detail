library(shiny)
library(shinyWidgets)
library(shinydashboard)
library(magrittr)
library(plyr)
library(dplyr)
library(stringr)
library(reshape2)#n R, we can transpose our data very easily
library(tidyr)
library(arules)
library(arulesViz)
library(datasets)
library(ggplot2)
library(plotly)

server<-shinyServer(function(input, output) {
  output$sum<-renderPrint({
    dong <- input$gg
    
    if (is.null(dong)) return(NULL)
    
    MBA_DATA<- read.transactions(
      dong$datapath,
      format = "single",
      sep = ",",
      cols=c(1,2),
      rm.duplicates = T)
    
    summary(MBA_DATA)
  })
  
  
  output$tops <- renderPrint({
    
    dong <- input$gg
    
    if (is.null(dong)) return(NULL)
    
    # grocer <- read.csv(CSSSV$datapath)
    #fRUIT <- read.transactions(dong$datapath, sep = ",")
    
    MBA_DATA<- read.transactions(
      dong$datapath,
      format = "single",
      sep = ",",
      cols=c(1,2),
      rm.duplicates = T)
    
    
    # set better support and confidence levels to learn more rules
    MBArules <- apriori(MBA_DATA, parameter = list(support =as.numeric(input$Sup), confidence = as.numeric(input$Conf)))
    Inter_data<-inspect(sort(MBArules,by="lift"))
    
    output$plot.absolute<-renderPlot({
      #plot(MBArules,method = "grouped")
      
      itemFrequencyPlot(MBA_DATA,topN=4, type="absolute", col="wheat2",xlab="Item name", 
                        ylab="Frequency (absolute)", main="Absolute Item Frequency Plot")
      
      
      output$plot.relative<-renderPlot({
        
        itemFrequencyPlot(MBA_DATA, topN=4, type="relative", col="lightcyan2", xlab="Item name", 
                          ylab="Frequency (relative)", main="Relative Item Frequency Plot")
        
        output$Rules<-renderPlot({
          plot(head(sort(MBArules,by ="lift"),10),method = "graph")
          
          output$Group<-renderPlot({
            plot(MBArules,method = "grouped")
          })
        })
      })
    })
    
  })
})