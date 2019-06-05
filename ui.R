
# This is the ui.R file for our web application

library(shiny)
library(plotly)
library(ggplot2)
library(shinythemes)
library(usmap)
library(knitr)


data <- read.csv("Minimum Wage Data.csv", stringsAsFactors = FALSE)

options(scipen=999)

shinyUI(fluidPage(theme = shinytheme("cerulean"),
                  
                  navbarPage("US Minimum Wage",
                  
                  tabPanel("Introduction",
                           uiOutput("intro")),
                  
                  tabPanel("Map", 
                           sidebarLayout(
                             sidebarPanel(
                               selectInput(inputId="year", label = "Select a year", choices = c(1968:2017),
                                           selected = "1968")
                               ),
                             mainPanel(
                               tabsetPanel(
                                 tabPanel("Map", plotOutput("mapHighOutput"), 
                                          uiOutput("summary"))
                               )
                             )
                           )),
                  
                  tabPanel("Plots",
                            sidebarLayout(
                              sidebarPanel(
      
                                selectInput(inputId="states",
                                           label = "Select state", choices=state.name,
                                          selected = "Washington", multiple = TRUE),
    
    
                sliderInput("years", "Range of years",
                            min = 1968,
                            max = 2017,
                            value = c(1968, 2000), sep = "")),
                            
                mainPanel(
                 tabsetPanel(
      
       tabPanel("CPI Average", plotlyOutput("cpiAvg"),
                uiOutput("CPIinfo")),
       tabPanel("Minimum Wage", plotlyOutput("highPlot"),
                uiOutput("wageSummary"))
      )
    )
)),

tabPanel(("Conclusion"), uiOutput("conclusion"))
)))
