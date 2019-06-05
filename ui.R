
#install.packages("ggplot2")

library(shiny)
library(plotly)
library(ggplot2)
library(shinythemes)
library(usmap)

data <- read.csv("~/Desktop/INFO/Final Project/Minimum Wage Data.csv", stringsAsFactors = FALSE)
# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("yeti"),
                  
                  # Application title
                  titlePanel("Minimum wages across US states from 1968 to 2017"),
                  
                  # Sidebar with a slider input for number of bins
                  sidebarLayout(
                      sidebarPanel(
                          
                          selectInput(inputId="states",
                                      label = "Select a state", choices=state.name,
                                      selected = "Washington", multiple = TRUE),
                          
                          selectInput(inputId="year", label = "Select a year", choices = c(1968:2017),
                                      selected = "2017"),
                          
                          sliderInput("years",
                                      "Range of years",
                                      min = 1968,
                                      max = 2017,
                                      value = c(1968, 2000))),
                      
                      # Show a plot of the generated distribution
                      mainPanel(
                            tabsetPanel(
                             tabPanel("Summary", p (strong("INTRODUCTION:")),
                                     
                                     p("Group 39: Palash, Shilpa, Keeke"),
                                     
                                     p("The dataset we are utilizing in this app is comprised of data pertaining to the US state minimum wages from 1968-2017. 
                                                     This dataset was taken from kaggle.com, and the data itself was from the US Department of Labor’s website. 
                                                     Within this data set, the values include year, state, high and low values of minimum wages from each of 
                                                     the years mentioned, consumer price index average per year, and the 2018 equivalent dollars 
                                                      for both the high and low values."), 
                                     p(imageOutput("minimum_wage_img")
                                       
                                      )),
                              tabPanel("High Value", plotlyOutput("highPlot")),
                              tabPanel("Low Vaue", plotlyOutput("lowPlot")),
                              tabPanel("Map", plotOutput("mapOutput"))

                          )
                      )
                  ))
)

