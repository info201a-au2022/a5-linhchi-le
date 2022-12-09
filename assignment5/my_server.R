# Load library
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)
library(shinythemes)



co_df <- read.csv(
  "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"
)


# DF of how Co2 changes over 2000 and later in Asian and US Countries (2020-2021)
co2_asia <- co_df %>%
  filter(country == "Thailand"| country == "Japan" | 
           country == "South Korea"| 
           country == "North Korea" | country == "China" | 
           country == "Mongolia" | country == "Cambodia",
         year > 1999) 

# Country in Asia (7 countries) with lowest amount of Co2 from 2000-2021
country_asia_low <- function() {
low_co2 <- co2_asia %>%
  select(country, co2, year) %>%
  group_by(country) %>%
  filter(year > 1999) %>%
  summarize(sum_co2 = sum(co2)) %>%
  filter(sum_co2 == min(sum_co2,na.rm = TRUE)) %>%
  pull(country)
return(low_co2)
}

# Year with the highest Co2 in Japan (2000-2021)
year_high_co2_japan <- function() {
high_japan_co2<- co2_asia %>%
  select(year, country, co2) %>%
  group_by(year) %>%
  filter(country == "Japan") %>%
  summarize(high_co2 = sum(co2, na.rm = TRUE)) %>%
  filter(high_co2 == max(high_co2, na.rm = TRUE)) %>%
  pull(year)
return(high_japan_co2)
}

# Total Co2 in Japan from 2000-2021
total_co2_japan <- function() {
japan_total <- co2_asia %>%
  select(country, co2, year) %>%
  filter(country == "Japan") %>%
  summarize(sum_japan_co2 = sum(co2)) %>%
  pull(sum_japan_co2)
return(japan_total)
}



# Define server logic 
my_server <- function(input, output) {
  
    output$linegraph <- renderPlotly({
      plotData <- co2_asia %>%
        filter(country %in% input$countryid)
      
      
      plot_asia <- ggplot(data = plotData, mapping = aes(
        x = year,
        y = co2
      )) +
        geom_line(aes(color = country)) + 
        scale_color_manual(values = input$pickcolor) +
        ggtitle("CO2 Emissions in Asian Countries
                (2000-2021)") +
        labs(x = "Year", y = "Annual total production-based emissions of CO2,
        excluding land-use change (million tonnes)") +
        labs(
          caption = "The figure showcases the amount of CO2 that each 
    country produces") +
        theme(plot.caption = element_text(hjust = 0.5))
    })
}


