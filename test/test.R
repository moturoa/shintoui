
library(shintoui)
library(glue)
library(leaflet)
library(DT)

.info <- shintoshiny::read_application_info()

header <- dashboard_header(title = "AdminLTE 3",
                           icon = bsicon("palette-fill"),
                           tag_line = "Een nieuw framework met Bootstrap4",
                           tags$li(class="dropdown",tags$div(id = "clock",
                                                             style="padding: 0.5rem;")))

sidebar <- dashboard_sidebar(
  menu_item("Menu 1", bsicon("tree"), "menu1"),
  menu_item("Analyses", bsicon("bar-chart"), "analyses")
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
               )
              ),
              column(6,

               shintoui::box(
                 title = "Auto's",
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

             shintoui::box(
               title = "Locaties",
               icon = bsicon("geo-alt-fill"),
               solidHeader = TRUE,
               status = "success",
               closable = TRUE,

               leafletOutput("mapout"),
               actionButton("btn1", "Button", class = "btn-primary", icon = bsicon("check"))
             )
    )
  )
)

ui <- dashboard_page(
  header = header,
  sidebar = sidebar,
  body = body
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

}

shinyApp(ui = ui,
         server = server)

