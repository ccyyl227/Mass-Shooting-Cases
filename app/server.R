library(shiny)
library(tidyverse)
library(ggplot2 )
library(maps)
server <- function(input, output) {
  

    
    # Filter data based on selected year
    # selected_year_data <- reactive({
    #   subset(cases_by_year, year == input$year)
    # })
    
    output$massshootings_plot <- renderPlot({
      cases_by_year$alpha <- ifelse(cases_by_year$year==input$year, 1, 0)
      
      ggplot(cases_by_year, aes(x = year, y = cases_total)) +
        geom_line() +
        geom_point(aes(size=cases_total, alpha=alpha), color="darkred" ) +
        scale_alpha(guide="none")+
        labs(x = "Year", y = "Number of Cases", title = "Mass Shooting Cases Over the Years") +
        theme_minimal()
    })
    output$map<-renderPlot({
      map_selected<-us_states_mass|>
        filter(year==input$year)
      p <- ggplot(data =  map_selected,
                  aes(x = long, y = lat,
                      group=group, fill = cases_total, color="black", size=0.25))
      p + geom_polygon(color = "gray90", size = 0.1) +scale_fill_gradient(low = "lightblue", high = "darkblue", name = "Cases") +
        coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
        labs(title = paste("Mass Shooting Cases by State in", input$year),fill = "Cases") +
        theme_minimal()
      
    })
}





