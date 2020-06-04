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

#   shiny market basket - quick and dirty tool for market basket analysis


ui<-shinyUI(fluidPage( tags$h2(""),
                       setBackgroundImage(
                         src = "https://wallpaperaccess.com/full/1624847.jpg"
                       ),
                       
                       
                       column(12,titlePanel("Intelligent Product Recommendation in Grocery Retail"),style = {'background-color:coral;'}),
                       
                       sidebarLayout(
                         sidebarPanel(
                           h2( align = "center", style = "color:black"),width = 3,
                           fileInput('gg', 'Choose CSV File', accept=c('.csv')),style = "background-color:brown; color:white",
                           
                           selectInput("Sup","Select Support",choices = c(0.1, 0.05, 0.01, 0.005)),
                           selectInput("Conf","Select Confidence",choices = c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9)),
                           helpText("Note: ",br(),
                                    "Support: The support of an itemset or  rules measures how frequently it occurs in the data.",br(),
                                    " Support = Count(X)/N",br(),
                                    "Confidence: A rule's confidence is a measurement of its predictive power or accuracy.",br(),
                                    "Confidence = Support(X,Y)/Support(X)",style = "color:White;"
                           )
                           
                           
                         ),
                         
                         mainPanel(width = 9,
                                   tabsetPanel(type = "tab",
                                               tabPanel("Summary",verbatimTextOutput("sum")),
                                               tabPanel("Apriori",verbatimTextOutput("tops")),
                                               tabPanel("Absolute Frequency plot",plotOutput("plot.absolute")),
                                               tabPanel("Relative Frequency plot",plotOutput("plot.relative")),
                                               tabPanel("Top Ten Apriori Rules With Arrow plots",plotOutput("Rules")),
                                               tabPanel("Grouped Metrixe Plot",plotOutput("Group"))
                                               
                                               
                                               
                                   ))
                       )
))