
library(shiny)
library(ggplot2)
library(plotly)
library(usmap)
library(shinythemes)

data <- read.csv("Minimum Wage Data.csv", stringsAsFactors = FALSE)
# Define server logic required to draw a histogram
shinyServer <- function(input, output) {
  
  output$cpiAvg <- renderPlotly({
    state_name <- filter(data, State==input$states)
    year_selected <- filter(state_name, Year>=input$years[1], Year<=input$years[2])
    print(year_selected)
    x <- year_selected$Year
    y <- year_selected$CPI.Average
    # p <- ggplot(year_selected) +
    #   geom_line(aes(x = Year, y = CPI.Average, color = State))
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
    # p <- ggplot(year_selected) +
    #   geom_line(aes(x = Year, y = High.Value, color = State)) +
    #   ggtitle("CPI vs Time") + theme(plot.title = element_text(hjust = 0.5, size=16))
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
  
  output$summary <- renderText({
    paste0("The map above displays the highest minimum wage for each state for the given year in the United States. 
           The states with a lighter shade of blue indicate high minimum wage, 
           whereas the states with a darker shade of blue indicate the lower minimum wage.")
  })
  
  output$CPIsummary <- renderText({
    paste0("The plot above shows the change in CPI(Consumer Price Index) over the given range of years. CPI is defiened as
           The Consumer Price Index (CPI) is a measure that examines the weighted average of prices of a basket of consumer 
           goods and services, such as transportation, food and medical care. It is calculated by taking price changes for 
           each item in the predetermined basket of goods and averaging them.")
  })
  
  output$wageSummary <- renderText({
    paste0("The plot above shows the change in minimum wage over the given range of years for the given state. You can select multiple
           states to observe minimum wage for different states at once. The Y-axis represents the minimum wage value in dollars and the
           X-axis represents the time in years.")
  })
  
  # output$mapLowOutput <- renderPlot({
  #   state_name <- filter(data, Year==input$year)
  #   # year_selected <- filter(state_name, Year>=input$years[1] & Year<=input$years[2])
  #   # x <- year_selected$Year
  #   # y <- year_selected$High.Value
  #   colnames(state_name)[2] <- "state"
  #   graph <- plot_usmap("state", data = state_name, values = "Low.Value", lines = "white") +
  #     scale_fill_continuous(name = "Low Value", label = scales::comma) +
  #     ggtitle("Lowest minimum wage in ", paste0(input$year)) +
  #     theme(legend.position = "right")
  #   return(graph)
  # })
  
}

