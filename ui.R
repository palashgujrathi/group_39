#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# bar plot()
# commiting
# commas in the year
# css and html

library(shiny)
library(plotly)
library(ggplot2)
library(shinythemes)
library(usmap)


data <- read.csv("Minimum Wage Data.csv", stringsAsFactors = FALSE)

options(scipen=999)
# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("cerulean"),
                  
                  navbarPage("US states minimum wages",
                  
                  tabPanel("Introduction",
                           tags$h1("INFO 201-Group 39"), br(),
                           
                           tags$ul(
                             tags$li("Palash Gujrathi"), 
                             tags$li("Shilpa Narayanan"), 
                             tags$li("Keeke Karuri")
                           ),
                           # tags$b(strong("Palash Gujrathi")), br(), 
                           # tags$b(strong("Shilpa Narayanan")), br(), 
                           # tags$b(strong("Keeke Karuri")), 
                           br(),
                           tags$code("About"),
                                p(strong("The dataset we are utilizing in this app is comprised of data pertaining to the 
                                US state minimum wages from 1968-2017. This dataset was taken from kaggle.com, and the data 
                                itself was from the US Department of Labor’s website. Within this data set, the values include year, 
                                state, high and low values of minimum wages from each of the years mentioned, consumer price index average 
                                per year, and the 2018 equivalent dollars for both the high and low values.")), br(),
                           
                    img(src = "https://www.shareicon.net/data/512x512/2017/01/06/868291_business_512x512.png",
                        style = "display: block; margin-left: auto; margin-right: auto; width: 50%;")),
                  
                  tabPanel("Map", 
                           sidebarLayout(
                             sidebarPanel(
                               selectInput(inputId="year", label = "Select a year", choices = c(1968:2017),
                                           selected = "1968")
                               ),
                             # Show a plot of the generated distribution
                             mainPanel(
                               tabsetPanel(
                                 tabPanel("Map", plotOutput("mapHighOutput"), 
                                          textOutput("summary"))
                               )
                             )
                           )),
                  
                  tabPanel("Plots",
                  
  
  # Application title
  # titlePanel("Minimum wages across US states from 1968 to 2017"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
    selectInput(inputId="states",
                label = "Select state", choices=state.name,
                selected = "Washington", multiple = TRUE),
    
    # selectInput(inputId="year", label = "Select a year", choices = c(1968:2017),
    #             selected = "1968"),
    
    sliderInput("years",
                "Range of years",
                min = 1968,
                max = 2017,
                value = c(1968, 2000))),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
      # tabPanel("Map", plotOutput("mapHighOutput"), textOutput("summary")),
      
      #tabPanel("Map", plotOutput("mapLowOutput")),
       tabPanel("CPI Average", plotlyOutput("cpiAvg"),
                textOutput("CPIsummary")),
       tabPanel("Minimum Wage", plotlyOutput("highPlot"),
                textOutput("wageSummary"))
      )
    )
)),
#here
tabPanel("Conclusion")
)))
