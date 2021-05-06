

#---- header -----

header <- dashboardHeader(

  title = tagList(
    span(icon("home"), class = "brand-image elevation-3", style = "padding-top: 8px;"),
    span(class = "brand-text font-weight-light", .info$this_version$appname),
  ),



  rightUi = tagList(
    tags$li(uiOutput("ui_tenantname", container = span), class = "dropdown gemeente_label"),
    tags$li(class = "dropdown",

            # About Menu
            tags$a(href="#", class="dropdown-toggle",
                   `data-toggle` = "dropdown",
                   icon("info-circle")
            )
    )
  )


  # tags$li(class = "dropdown",
  #
  #         # About Menu
  #         tags$a(href="#", class="dropdown-toggle",
  #                `data-toggle` = "dropdown",
  #                icon("info-circle")
  #         ),
  #         tags$ul(class="dropdown-menu aboutmenu", style = "min-width: 300px; padding: 25px;",
  #                 shintoshiny::appInfoUI("appinfo", info = .info)
  #         )
  #
  # ),
  #
  # shintoshiny::userLogoutUI("logout")
)

#----- Sidebar -----

sidebar <- dashboardSidebar(

  sidebarMenu(id = "sidebar",
              menuItem("Home", icon = icon("tachometer"), tabName = "tabStart"),
              menuItem("Panden", icon = icon("home"), tabName = "tabPandViewer"),
              menuItem("Buurten", icon = icon("city"), tabName = "tabBuurtViewer"),
              menuItem("Casus", icon = icon("map-marker"), tabName = "tabCasus"),

              tags$hr(),
              menuItem("Admin", icon = icon("cogs"), tabName = "tabAdmin")

  )

)


#----- Body -----

body <- bs4Dash::dashboardBody(

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

            frontpageUI("frontpage")

    ),

    tabItem(tabName = "tabPandViewer",

            pandViewerUI("pandview")

    ),

    tabItem(tabName = "tabBuurtViewer",

            buurtViewerUI("buurtview")

    ),

    tabItem(tabName = "tabCasus",

            casusUI("casus")

    )


  )

)


#----- dashboardPage -----
ui <- dashboardPage(
  header = header,

  sidebar = sidebar,

  body = body,

  fullscreen = TRUE,
  dark = FALSE,
  scrollToTop = TRUE
)


shinyApp(
  ui= ui,
  server = function(input,output,session){}
)

