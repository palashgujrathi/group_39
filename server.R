

# This is the Server.R file for our web application

library(shiny)
library(ggplot2)
library(plotly)
library(usmap)
library(knitr)

data <- read.csv("Minimum Wage Data.csv", stringsAsFactors = FALSE)


shinyServer <- function(input, output) {
   
  output$cpiAvg <- renderPlotly({
    state_name <- filter(data, State==input$states)
    year_selected <- filter(state_name, Year>=input$years[1], Year<=input$years[2])
    print(year_selected)
    x <- year_selected$Year
    y <- year_selected$CPI.Average
    p <- plot_ly(year_selected, x = ~x, y = ~y, color = year_selected$State, type = 'scatter', mode = 'lines') %>%
          layout(xaxis = list(title = "YEARS"), yaxis = list(title = "CPI ($)"),
             title = paste("CPI ($) vs YEARS", min(input$years), "-", max(input$years)), margin = list(t=120))
    return(p)
  })
  
  output$highPlot <- renderPlotly({
    state_name <- filter(data, State %in% input$states)
    year_selected <- filter(state_name, Year>=input$years[1], Year<=input$years[2])
    x <- year_selected$Year
    y <- year_selected$High.Value
    p <- plot_ly(year_selected, x = ~x, y = ~y, color = ~year_selected$State, type = 'scatter', mode = 'lines') %>%
          layout(xaxis = list(title = "YEARS"), yaxis = list(title = "MINIMUM WAGE ($)"),
             title = paste("MINIMUM WAGE ($) vs YEARS", min(input$years), "-", max(input$years)), margin = list(t=120))#FF8C00
    return(p)
  })
  
  output$mapHighOutput <- renderPlot({
    year_range <- filter(data, Year==input$year)
    colnames(year_range)[2] <- "state"
  
      graph <- plot_usmap("state", data = year_range, values = "High.Value", lines = "white") +
        scale_fill_continuous(name = "High Value", label = scales::comma) +
        ggtitle("Minimum wage in ", paste0(input$year)) +
        theme(legend.position = "right")
      return(graph)
  })
  
  output$summary <- renderUI({
    HTML(markdown::markdownToHTML(knit("mapText.Rmd", quiet = TRUE)))
  })
  
  
  
  output$wageSummary <- renderUI({
    HTML(markdown::markdownToHTML(knit("wageIntro.Rmd", quiet = TRUE)))
  })
  
  output$intro <- renderUI({
    HTML(markdown::markdownToHTML(knit("intro.Rmd", quiet = TRUE)))
  })
  
  output$conclusion <- renderUI({
    HTML(markdown::markdownToHTML(knit("consulsion.Rmd", quiet = TRUE)))
  })
  
}
