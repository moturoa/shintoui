





#' Make the header UI for a Shinto app
#' @param title Title of the application (top-left)
#' @param icon Icon next to title
#' @param \dots Further UI elements to be placed in the right part of the header
#' @export
dashboard_header <- function(title = "Shinto app framework",
                             icon = shiny::icon("home"),
                             tag_line = "",
                             ...){
  bs4Dash::dashboardHeader(

    status = "white",

    title = tagList(
      span(icon, style = "padding-top: 8px; padding-left: 16px;"),  #class = "brand-image elevation-3",
      span(class = "brand-text", title),
    ),

    leftUi = tags$li(tags$i(tag_line), class = "dropdown",
                     style = "padding-top: 8px; padding-left: 24px;"),

    rightUi = tagList(...,

                      tags$li(class="dropdown",tags$div(id = "clock",
                                                        style="padding: 0.5rem;")),

                      tags$li(class = "nav-item dropdown",

                              # About Menu
                              tags$a(href="#",
                                     class="nav-link",
                                     `data-toggle` = "dropdown",
                                     title = "Applicatie informatie",
                                     tags$span(bsicon("info-circle"),
                                               style = "font-weight: 800; font-size: 1.1em;")
                              ),
                              tags$ul(class="dropdown-menu aboutmenu",
                                      style = "min-width: 300px; padding: 25px;",
                                      shintoshiny::appInfoUI("appinfo")
                              )
                      ),

                      tags$li(class = "nav-item dropdown",
                        tags$a(href = "https://shintolabs.atlassian.net/servicedesk",
                          target = "_blank",
                          class = "nav-link",
                          bsicon("question-circle-fill"),
                          title = "Service Desk"),
                     ),


                      bs4Dash::dropdownMenu(type = "notifications",
                                                   icon =  bsicon("person-circle"),
                                                   headerText = textOutput("shintoui-txt_username", inline = TRUE),
                                                   badgeStatus = NULL,
                                                   
                                            tags$a(class = "dropdown-item", href = "",
                                                   shiny::icon("sync"),
                                                   "Klik om te herladen"
                                                   ),
                                            tags$div(class = "dropdown-divider"),
                                            tags$a(class = "dropdown-item", href = "",
                                                   onclick = "window.close();",
                                                   shiny::icon("window-close"),
                                                   "Sluit de applicatie"
                                            )
                      )
                                            
                      )
  )
}

#' Make a sidebar for a Shinto app
#' @param \dots All arguments passed to bs4Dash::sidebarMenu
#' @rdname dashboard_sidebar
#' @export
dashboard_sidebar <- function(...){
  bs4Dash::dashboardSidebar(skin = "light",
    ...,
    tags$div(
      style = "position: fixed; bottom: 16px; left: 16px;",
      tags$img(src = "shintoui_assets/logo/logoshintolabs96.png",
               width = "24px")
    )
  )
}

#' Side bar menu
#' @rdname dashboard_sidebar
sidebar_menu <- function(...){
  bs4Dash::sidebarMenu(
    ...
  )
}

#' Render a dashboard menu
#' @rdname dashboard_sidebar
#' @export
render_menu <- function(...){

  bs4Dash::renderMenu(...)

}

#' Render a dashboard menu
#' @rdname dashboard_sidebar
#' @export
sidebar_menuoutput <- function(...){
  bs4Dash::sidebarMenuOutput(...)
}






#' Make a Menu item for a Shinto app
#' @param text Text to be displayed in the menu
#' @param icon Icon for menu item (must use e.g. icon("home"))
#' @param tabName Name of the tab, must refer to a tabitem.
#' @export
menu_item <- function(text, icon, tabName, ...){

  bs4Dash::menuItem(text = text, icon = icon, tabName = tabName, ...)

}


#' Make a body for a Shinto app bs4Dash::dashboardBody with various common dependencies (shinyjs, shinytoastr,
#' bootstrap icons, etc.)
#' @description Wrapper around
#' @param \dots UI arguments passed to bs4Dash::dashboardBody
#' @param busybar_color Color of 'busy bar'
#' @param loadingscreen_time Loading time (not yet implemented)
#' @param disconnect_message Message for disconnect popup
#' @importFrom shinybusy add_busy_bar
#' @importFrom shinyjs useShinyjs
#' @importFrom shinytoastr useToastr
#' @export
dashboard_body <- function(...,
                           busybar_color = "#53C082",
                           clock = TRUE,
                           loadingscreen_time = 2,
                           disconnect_message = "Oeps, er ging iets fout! Herlaad de pagina en probeer het nog een keer."){
  bs4Dash::dashboardBody(

    tags$head(
      HTML('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">'),
      HTML(paste('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"',
                  'integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">')),

      tags$script(
        HTML('@import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css");')
      )
    ),



    shinyjs::useShinyjs(),
    shinyjs:::extendShinyjs(text = "shinyjs.collapse = function(boxid) {
                    $('#' + boxid).closest('.card').find('[data-card-widget=collapse]').click();}",
                    functions = "collapse"),
    shinytoastr::useToastr(),

    # Nodig voor app info dropdown
    shintoshiny::shintoshiny_dependencies(),

    shintoui::shintoui_dependencies(),

    if(clock){
      includeScript(system.file("assets/clock/clock.js", package = "shintoui"))
    },

    # Loading bar, loading screen
    shinybusy::add_busy_bar(color = busybar_color, height = "6px"),

    shintoshiny::loadingscreen(time = loadingscreen_time),
    shintoshiny::disconnect_message(disconnect_message),
    ...)
}

#' Make a content box for a shiny app
#' @param title Title of the box
#' @param icon Icon to be placed to the left of title (must use e.g. icon("home"))
#' @export
box <- function(title = "",  ..., icon = NULL){

  bs4Dash::box(title = tagList(icon, title), ...)

}

#' Minimize/maximize a box
#' @param id Box id
#' @export
toggle_box <- function(id){
  js$collapse(id)
}

#' Various tab item, menu, wrapper functions
#' @rdname tabwrappers
#' @export
tab_box <- function(...){

  bs4Dash::bs4TabCard(...)

}

#' @rdname tabwrapper
#' @export
tab_panel <- function(...){

  shiny::tabPanel(...)

}


#' Make a tabset panel (Bootstrap 4)
#' @rdname tabwrapper
#' @export
tabset_panel <- function(...){

  bs4Dash::tabsetPanel(...)

}

#' @rdname tabwrapper
#' @export
tab_items <- function(...){

  bs4Dash::tabItems(...)

}

#' @rdname tabwrapper
#' @export
tab_item <- function(tabName, ...){

  bs4Dash::tabItem(tabName = tabName, ...)

}

#' Make a dashboard page for a Shinto app
#' @export
dashboard_page <- function(header, sidebar, body, ...){


  bs4Dash::dashboardPage(
    header = header,

    sidebar = sidebar,

    body = body,

    fullscreen = FALSE,
    dark = NULL,
    scrollToTop = FALSE,
    ...
  )

}



