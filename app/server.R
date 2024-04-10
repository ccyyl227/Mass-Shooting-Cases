library(shiny)
library(tidyverse)
library(ggplot2 )
server <- function(input, output) {
  
  # Filter data based on selected year
  selected_year_data <- reactive({
    subset(cases_by_year, year == input$year)
  })
  
  output$massshootings_plot <- renderPlot({
    ggplot(cases_by_year, aes(x = year, y = cases_total)) +
      geom_line() +
      geom_point(data = selected_year_data(), aes(size = cases_total), color="darkred" ) +
      labs(x = "Year", y = "Number of Cases", title = "Mass Shooting Cases Over the Years") +
      theme_minimal()
  })
}