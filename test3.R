

source("R/wrappers.R")

library(shiny)
library(shinyjs)
#library(shintoshiny)
library(shinytoastr)
library(bs4Dash)


header <- dashboard_header(title = "Test app")

sidebar <- dashboard_sidebar(
  menu_item("Menu 1", icon("tree"), "menu1"),
  menu_item("Analyses", icon("bar-chart"), "analyses")
)

# body <- dashboard_body(
#   tab_items(
#     tab_item("menu1", tags$p("content"))
#   )
# )

ui <- dashboardPage(
  header = header,

  sidebar = sidebar,

  body = bs4Dash::dashboardBody(

    tags$head(
      tags$link(rel = "shortcut icon", href = "favicon.ico")
    ),

    useShinyjs(),
    useToastr(),

    # Nodig voor app info dropdown
    #shintoshiny::shintoshiny_dependencies(),

    # Loading bar, loading screen
    shinybusy::add_busy_bar(color = "#53C082", height = "6px"),

    shintoshiny::loadingscreen(time = 1),
    shintoshiny::disconnect_message(),

    # Custom CSS.
    #includeCSS("www/shintolabs.css"),
    #includeCSS("www/buttons.css"),
    #includeCSS("www/newsstyle.css"),

    # Custom JS
    #includeScript("www/shintolabs.js"),


    tabItems(
      tabItem(tabName = "tabStart",

              #frontpageUI("frontpage")
tags$p("content")
      ),

      tabItem(tabName = "tabPandViewer",

              tags$p("content")

      ),

      tabItem(tabName = "tabBuurtViewer",

              tags$p("content")

      ),

      tabItem(tabName = "tabCasus",

              tags$p("content")

      )


    )

  ),

  fullscreen = TRUE,
  dark = FALSE,
  scrollToTop = TRUE
)

shinyApp(ui = ui, server = function(input, output, session){

})


