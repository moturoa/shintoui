
library(shintoui)
library(glue)
library(leaflet)
library(DT)
library(ggplot2)
library(dplyr)

.info <- shintoshiny::read_application_info()

header <- dashboard_header(title = "AdminLTE 3",
                           icon = bsicon("palette-fill"),
                           tag_line = "Een nieuw framework met Bootstrap4")

sidebar <- dashboard_sidebar(
  sidebar_menu(
    menu_item("Menu 1", bsicon("tree"), "menu1"),
    menu_item("Analyses", bsicon("bar-chart"), "analyses")
  )
)

body <- dashboard_body(

  loadingscreen_time = 1,
  clock = TRUE,

  shintoui::tab_items(
    shintoui::tab_item("menu1",

            fluidRow(
              column(6,
               shintoui::box(
                 title = "Analyses",
                 width = 12,
                 icon = bsicon("graph-up"),
                 solidHeader = TRUE,
                 status = "primary",
                 maximizable = TRUE,

                 tags$p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras dictum urna in tempus viverra. Fusce eleifend, urna eu fermentum tincidunt, nisi felis consectetur ex, eu ornare lorem ipsum ut dui. Curabitur accumsan luctus lectus, eget suscipit est hendrerit quis. Orci varius natoque penatibus et magnis dis parturient montes,
                        nascetur ridiculus mus. Morbi interdum ultricies risus, non viverra sem aliquam ac.")
               ),
               shintoui::box(
                 title = "Status / buttons",
                 icon = bsicon("bookmark-fill"),
                 width = 12,
                 closable = TRUE,

                 tags$div(style = "padding: 24px;", actionButton("btn1", "Primary", class = "btn-primary", icon = bsicon("person-check"))),
                 tags$div(style = "padding: 24px;", actionButton("btn1", "Secondary", class = "btn-secondary", icon = bsicon("exclamation-diamond"))),
                 tags$div(style = "padding: 24px;", actionButton("btn1", "Success", class = "btn-success", icon = bsicon("check"))),
                 tags$div(style = "padding: 24px;", actionButton("btn1", "Info", class = "btn-info", icon = bsicon("question-circle"))),
                 tags$div(style = "padding: 24px;", actionButton("btn1", "Light", class = "btn-light", icon = bsicon("exclamation-diamond"))),
                 tags$div(style = "padding: 24px;", actionButton("btn1", "Warning", class = "btn-warning", icon = bsicon("exclamation-diamond"))),
                 tags$div(style = "padding: 24px;", actionButton("btn1", "Danger", class = "btn-danger", icon = bsicon("exclamation-diamond")))
               )
              ),
              column(6,

               shintoui::box(
                 title = "Datatable",
                 icon = bsicon("car"),
                 width = 12,
                 closable = TRUE,

                 DT::dataTableOutput("dt_out"),
                 tags$br(),
                 actionButton("btn1", "Button", class = "btn-secondary", icon = bsicon("person-check")),
                 actionButton("btn1", "Warning", class = "btn-warning", icon = bsicon("exclamation-diamond"))
               )
              )
            )
             ),
    shintoui::tab_item("analyses",

              fluidRow(
                  column(6,
                         shintoui::box(
                           width = 12,
                           title = "Locaties",
                           icon = bsicon("geo-alt-fill"),
                           solidHeader = TRUE,
                           status = "success",
                           closable = TRUE,

                           leafletOutput("mapout"),
                           actionButton("btn1", "Button", class = "btn-primary", icon = bsicon("check"))
                         ),

                         shintoui::box(
                           title = "Een box met een tabset_panel",
                           width = 12,
                           icon = bsicon("bug-fill"),
                           solidHeader = TRUE,
                           status = "success",


                           tabset_panel(
                             tab_panel("Tab 1", tags$p("content")),
                             tab_panel("Tab 2", tags$p("content")),
                             tab_panel("Tab 3", tags$p("content"))
                           )
                         )

                  ),
                  column(6,

                         shintoui::plotBoxUI("plot1", "Een grafiekje titel", width = 12),
                         shintoui::tab_box(title = "Een tab_box", width = 12,

                                           tab_panel("Tab 1", tags$p("content")),
                                           tab_panel("Tab 2", tags$p("content")),
                                           tab_panel("Tab 3", tags$p("content"))
                         )

                  )
              )









    )
  )
)

ui <- dashboard_page(
  header = header,
  sidebar = sidebar,
  body = body,
  controlbar = dashboardControlbar(skinSelector(), pinned = TRUE)
)

server <- function(input, output, session){

  shintoui::populate_header(username = shintoshiny::get_user("devuser"))

  output$mapout <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(data = data.frame(lat = 51, lon = 4.5))
  })

  output$dt_out <- DT::renderDataTable({

    shintoui::datatafel(mtcars)

  })


  callModule(shintoui::plotBox, "plot1", data = reactive(mtcars),

             plot_function = function(data){
               ggplot(mtcars, aes(x = wt, y = disp)) +
                 geom_point(size = 3) +
                 theme_minimal()
             },

             table_function=  function(data){
               dplyr::select(data, wt, disp) %>% head(10)
             }

             )

}

shinyApp(ui = ui,
         server = server)

