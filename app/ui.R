library(shiny)

ui <- fluidPage(
  titlePanel("Mass Shooting Cases Over the Years"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("year", "Year", min = min(massshootings$year), max = max(massshootings$year), value = min(massshootings$year), step = 1)
      
  ),
    mainPanel(
      plotOutput("massshootings_plot"),
      plotOutput("map")
    )
  )
)