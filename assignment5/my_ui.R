# Load libraries
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)

# Define UI for application that draws a histogram
my_ui <- fluidPage(
  
  page_one <- tabPanel(
    "Introduction", 
    titlePanel("Intro"), 
    
  ),
)
    page_two <- tabPanel(
      "CO2 Emissions", 
      titlePanel("CO2 Emissions in Asian Countries"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "countryid",
        label = "Choose a country:",
        choices = c("Japan", "Vietnam", "Thailand"),
      ),
    selectInput(
      inputId = "colorid",
      label = "Choose a color",
      choices = c("black", "blue", "red"),
    ),
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("linegraph"),
    )
  )
)

my_ui <- navbarPage(
  "CO2",
  page_one,
  page_two,
)
