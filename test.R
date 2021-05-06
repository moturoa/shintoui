

source("R/wrappers.R")

library(shiny)
library(shinyjs)
#library(shintoshiny)
library(shinytoastr)
#library(bs4Dash)


header <- dashboard_header(title = "Test app",
                           icon = bsicon("house-fill"))

sidebar <- dashboard_sidebar(
  menu_item("Menu 1", bsicon("tree"), "menu1"),
  menu_item("Analyses", bsicon("bar-chart"), "analyses")
)

body <- dashboard_body(
  tab_items(
    tab_item("menu1",
             tags$p("content"),
             bsicon("archive")
             )
  )
)

ui <- dashboard_page(
  header = header,
  sidebar = sidebar,
  body = body
)

server <- function(input, output, session){

  populate_header()

}

shinyApp(ui = ui,
         server = server)

