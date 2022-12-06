# Load library
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)
library(plotly)

co_df <- read.csv(
  "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"
)

# Country with lowest amount of Co2 from 2020-2021
country_low <- co_df %>%
  select(country, co2, year) %>%
  group_by(country) %>%
  filter(year > 1999) %>%
  summarize(sum_co2 = sum(co2)) %>%
  filter(sum_co2 == min(sum_co2,na.rm = TRUE)) %>%
  pull(country)

# Year with the highest Co2 in USA
year_high_co2_usa <- co_df %>%
  select(year, country, co2) %>%
  group_by(year) %>%
  filter(country == "United States") %>%
  summarize(high_co2 = sum(co2, na.rm = TRUE)) %>%
  filter(high_co2 == max(high_co2, na.rm = TRUE)) %>%
  pull(year)

# Total Co2 in USA 
total_co2_usa_ <- co_df %>%
  select(country, co2, year) %>%
  filter(country == "United States") %>%
  summarize(sum_usa_co2 = sum(co2)) %>%
  pull(sum_usa_co2)
  


# DF of how Co2 changes over years in Asian Countries (2020-2021)
co2_asia <- co_df %>%
  filter(country == "Vietnam" | country == "Thailand"| country == "Japan", 
         year > 1999) 



# Define server logic 
my_server <- function(input, output) {
    output$linegraph <- renderPlotly({
      
      plotData <- co2_asia %>%
      filter(country %in% input$countryid)
        
      plot_asia <- ggplot(data = plotData, mapping = aes(
        x = year,
        y = co2
      )) +
        geom_line(aes(color = country), stat = "identity") +
        ggtitle("CO2 Emissions in Asian Countries (2000-2021)") +
        labs(x = "Year", y = "Total Production-Based Emissions of Carbon
             Dioxide") +
        labs(
          caption = "The figure showcases the amount of CO2 that each 
    country produces.") +
        theme(plot.caption = element_text(hjust = 0.5))
    })
}


