
# Load Libraries
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)
library(shinythemes)



# Sourcing
source("my_ui.R")
source("my_server.R")


# Run the application
shinyApp(ui = my_ui, server = my_server)

