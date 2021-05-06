


username_module <- function(input, output, session, username = "unknown"){

  output$txt_username <- renderText({
    username
  })

}

populate_header <- function(username){

  callModule(username_module, "shintoui", username = "Shinto Labs")

  callModule(shintoshiny::appInfoModule, "appinfo")

}




dashboard_header <- function(title = "Shinto app framework",
                             icon = shiny::icon("home"),
                             ...){
  bs4Dash::dashboardHeader(

    title = tagList(
      span(icon, class = "brand-image elevation-3", style = "padding-top: 8px;"),
      span(class = "brand-text font-weight-light", title),
    ),

    rightUi = tagList(...,


                      tags$li(class = "dropdown",

                              # About Menu
                              tags$a(href="#",
                                     class="nav-link",
                                     `data-toggle` = "dropdown",
                                     bsicon("info-circle")
                              ),
                              tags$ul(class="dropdown-menu aboutmenu",
                                      style = "min-width: 300px; padding: 25px;",
                                      shintoshiny::appInfoUI("appinfo")
                              )
                      ),

                      bs4Dash::dropdownMenu(type = "notifications",
                                                   icon =  bsicon("person-circle"),
                                                   headerText = textOutput("shintoui-txt_username", inline = TRUE),
                                                   badgeStatus = NULL,
                                                   bs4Dash::notificationItem(
                                                     text = "Log uit",
                                                     bsicon("box-arrow-right"),
                                                     href="__logout__"
                                                   )
                      )
                      )
  )
}

dashboard_sidebar <- function(...){
  bs4Dash::dashboardSidebar(
    bs4Dash::sidebarMenu(
      ...
    )
  )
}

menu_item <- function(text, icon, tabName, ...){

  bs4Dash::menuItem(text = text, icon = icon, tabName = tabName, ...)

}



dashboard_body <- function(...,
                           busybar_color = "#53C082",
                           loadingscreen_time = 2,
                           disconnect_message = "Oeps, er ging iets fout! Herlaad de pagina en probeer het nog een keer."){
  bs4Dash::dashboardBody(

    tags$head(
      HTML('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">'),
      tags$script(
        HTML('@import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css");')
      )
    ),


    useShinyjs(),
    useToastr(),

    # Nodig voor app info dropdown
    #shintoshiny::shintoshiny_dependencies(),

    # Loading bar, loading screen
    shinybusy::add_busy_bar(color = busybar_color, height = "6px"),

    shintoshiny::loadingscreen(time = loadingscreen_time),
    shintoshiny::disconnect_message(disconnect_message),
    ...)
}

box <- function(...){

  bs4Dash::box(...)

}

tab_box <- function(...){

  bs4Dash::bs4TabCard(...)

}

tab_panel <- function(...){

  shiny::tab_panel(...)

}

tab_items <- function(...){

  bs4Dash::tabItems(...)

}
tab_item <- function(tabName, ...){

  bs4Dash::tabItem(tabName = tabName, ...)

}

dashboard_page <- function(header, sidebar, body, ...){


  bs4Dash::dashboardPage(
    header = header,

    sidebar = sidebar,

    body = body,

    fullscreen = FALSE,
    dark = NULL,
    scrollToTop = FALSE
  )

}



bsicon <- function(iconname, class = NULL, ...){

  iconClass <- paste0("bi-",iconname)

  if(!is.null(class)){
    iconClass <- paste(iconClass, class)
  }

  tags$i(class = iconClass, role = "presentation",
         `aria-label` = paste(iconname, "icon"), ...)
}










