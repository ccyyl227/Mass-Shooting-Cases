library(shiny)
library(bslib)
library(ggplot2)
library(tidyverse)

massshootings <- read_csv("data/Mother Jones - Mass Shootings Database, 1982 - 2023 - Sheet1.csv")

cases_by_year <- massshootings |>
  group_by(year) |>
  summarise(cases_total = n())

ui <- fluidPage(
  titlePanel("Mass Shooting Cases Over the Years"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("year", "Year", min = min(massshootings$year), 
                  max = max(massshootings$year), value = min(massshootings$year), step = 1)
    ),
    mainPanel(
      plotOutput("massshootings_plot")
    )
  )
)

server <- function(input, output) {
  
  # Filter data based on selected year
  # selected_year_data <- reactive({
  #   subset(cases_by_year, year == input$year)
  # })
  
  output$massshootings_plot <- renderPlot({
    ggplot(cases_by_year, aes(x = year, y = cases_total)) +
      geom_line() +
      geom_point(aes(size=case_total), color="darkred" ) +
      labs(x = "Year", y = "Number of Cases", title = "Mass Shooting Cases Over the Years") +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)


