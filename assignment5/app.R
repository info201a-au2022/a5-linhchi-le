#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/

# Libraries
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)

# Sourcing
source("my_ui.R")
source("my_server.R")


# Run the application 
shinyApp(ui = my_ui, server = my_server)