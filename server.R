#install.packages("usmap")

library(shiny)
library(ggplot2)
library(plotly)
library(usmap)
library(readr)

data <- read.csv("~/Desktop/INFO/Final Project/Minimum Wage Data.csv")
# Define server logic required to draw a histogram
shinyServer <- function(input, output) {
    
    # output$highPlot <- renderPlotly({
    #     state_name <- filter(data, State==input$states)
    #     year_selected <- filter(state_name, Year>=input$years[1] & Year<=input$years[2])
    #     x <- year_selected$Year
    #     y <- year_selected$High.Value
    #     p <- plot_ly(year_selected, x = ~x, y = ~y, colors = "#FF8C00", type = 'scatter', mode = 'lines')
    #     return(p)
    # })
    # 
    # output$lowPlot <- renderPlotly({
    #     state_name <- filter(data, State==input$states)
    #     year_selected <- filter(state_name, Year>=input$years[1] & Year<=input$years[2])
    #     x <- year_selected$Year
    #     y <- year_selected$Low.Value
    #     p <- plot_ly(year_selected, x = ~x, y = ~y, color = "##e5541e", type = 'scatter', mode = 'lines')
    #     return(p)
    #})
    
    ## New plot that shows Minimum wage overall: 
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

    
    output$mapOutput <- renderPlot({
        state_name <- filter(data, Year==input$year)
        # year_selected <- filter(state_name, Year>=input$years[1] & Year<=input$years[2])
        # x <- year_selected$Year
        # y <- year_selected$High.Value
        colnames(state_name)[2] <- "state"
        graph <- plot_usmap("state", data = state_name, values = "High.Value", lines = "white") +
            scale_fill_continuous(name = "Low Value", label = scales::comma) +
            ggtitle("Lowest minimum wage in ", paste0(input$year)) +
            theme(legend.position = "right")
        return(graph)
    })
    
    output$minimum_wage_img <- renderImage({
        outfile <- tempfile(fileext = '.png')
        png (outfile, width = 400, height = 300)
        hist(rnorm(input$obs), main = "Generated in renderImage()")
        dev.off()
        list(src = outfile,
             contentType = 'image/png',
             width = 400,
             height = 300,
             alt = "This is alternate text")
    }, deleteFile = TRUE)
}

        

