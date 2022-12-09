# Load libraries
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly) 
library(dplyr)
library(shinythemes)

# Sourcing server
source("my_server.R")

# Putting values from server to the UI
country_asia_low <- country_asia_low()
total_co2_japan <- total_co2_japan()
year_high_co2_japan <- year_high_co2_japan()


# Define UI for application that draws a histogram
my_ui <- fluidPage(
  
  page_one <- tabPanel(
    "Introduction", 
    titlePanel("Intro"),
    h3("Introduction to Carbon Dioxide"),
    p("Climate change has been a large issue for years, and it has not seem to 
      be improving. Humans are a big cause of global warming and climate 
      change, since we have produced large amounts of carbon dioxide. The 
      transportations, factories, and deforestation all play a role 
      on how humans produce carbon dioxide."),
    p("For this assignment, I am using data from Our World in Data, which has 
      information about CO2 and greenhouse gas emissions in each country in the 
      world. The years in the dataset ranged from 1850 to 2021, however, I 
      decided to focus on countries from the year 2000 to 2021 to narrow it 
      down. I also decided to choose seven countries in Asia to compare them 
      and see how different the amount of carbon dioxide would be for each 
      country. The countries that I chose are Thailand, North Korea, South 
      Korea, China, Mongolia, Japan and Cambodia. From the Our World in Data 
      dataset, I chose to use the category that has the annual total production
      based emissions of carbon dioxide. This category is represented in million 
      tonnes, and does not include land-use change. The columns that I used 
      from the dataset were country, year, and co2."),
    h3("Three Relevant Values"),
    p("To start off, I chose some questions that I wanted to answer because
      I wanted to know the basics of some Asia countries."),
    p(" - What is the country in Asia (out of seven countries) with lowest 
    amount of Co2 from 2000-2021?"),
    p("- What is the year with the highest amount of carbon dioxide in Japan 
    from 2000-2021?"), 
    p("- What is the total amount of carbon dioxide in Japan from 2000-2021?"),
    p("For my first value, I found out that the country in Asia out of the 
    seven that I focused on that had the lowest amount of CO2 from 2000 to 
      2021 was", paste(country_asia_low), "."),
    p("Next, the year that had the highest amount of carbon dioxide in Japan 
      from 2000 to 2021 was", paste(year_high_co2_japan),"."),
    p("Finally, I figured out that the total amount of carbon dioxide in Japan 
      from 2000 to 2021 was", paste(total_co2_japan)," million tonnes."),
    h3("Visualization"),
    p("In my project, I have created a chart that allows the user to input a 
      country out of the seven that I have mentioned. The user would be able to 
      see the amount of carbon dioxide that the country produces."),
    img("",
      src = "https://assets.terrapass.com/wp-content/uploads/2022/08/carbon-dioxide-emissions-from-electricity-photo-of-factory-smoke.jpg", 
      height = "350px", width = "600px",
      style= "position:absolute;"),
  ),
)
    page_two <- tabPanel(
      "CO2 Emissions", 
      titlePanel("CO2 Emissions in Seven Asian Countries"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = "countryid", 
                         label = "Select a country",
                         c("Japan", "Thailand", "South Korea",
                           "North Korea", "China", "Mongolia", "Cambodia")
    ),
    
    selectInput(
      inputId = "pickcolor",
      label = "Choose a color:",
      choices = c("red", "blue", "pink", "purple", "black", "orange", "green")
    )
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("linegraph"),
      p("In this chart, a country from Asia (China, North Korea, South Korea,
        Cambodia, Japan, Mongolia, and Thailand) can be selected. A color can 
        also be chosen to change the color of the line. The graph shows the 
        annual total production-based emissions of carbon dioxide in the 
        selected country. I included this chart because I was interested in 
        finding out which country would have a higher amount of carbon dioxide.
        I found out that China has the highest amount of carbon dioxide, which 
        makes sense because China has a large population of people, and it is 
        also a very large country. Mongolia has the least amount of carbon 
        dioxide, and it has the lowest population out of the listed countries.
        An interesting trend I saw in North Korea was that there was a 
        significant decrease in 2006, which continued until 2015. Countries 
        like Thailand, South Korea, China, Mongolia, and Cambodia has a 
        pattern of increasing levels of carbon dioxide."),
    )
    

)
)



my_ui <- navbarPage(
  theme = shinytheme("united"),
  "CO2 Emissions",
  page_one,
  page_two,
)
