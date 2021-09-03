#Load libraries
library(shiny)
library(leaflet)
library(shinycssloaders)
library(shiny.semantic)
library(geosphere)
library(tidyverse)
library(readr)
library(testthat)

# Get Ships data
ships <- read_csv("./www/inputs/ships.csv")

# Define simple ships type object
types <- ships %>%
  filter(ship_type == unique(ships$ship_type)[1])

# Call modules
source("./R/module.R")