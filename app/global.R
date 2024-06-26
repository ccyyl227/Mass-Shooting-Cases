library(shiny)
library(bslib)
library(ggplot2)
library(tidyverse)

massshootings <- read_csv("Mother Jones - Mass Shootings Database, 1982 - 2023 - Sheet1.csv")

cases_by_year <- massshootings |>
  group_by(year) |>
  summarise(cases_total = n())

states <-massshootings |>
  group_by(year,location...2)|>
  summarise(cases_total = n())
states <- states %>% mutate(state = map_chr(str_split(location...2, ", "), pluck, 2))


us_states <- map_data("state")
states$region<- tolower(states$state)


