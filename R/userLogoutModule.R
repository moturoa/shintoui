#' Shiny module for logout menu
#' @param id Input id
#' @param username Use \code{\link{get_user}} to get the current user.
#' @rdname userLogoutModule
#' @importFrom shinydashboard dropdownMenuOutput
#' @export
userLogoutUI <- function(id){

  ns <- NS(id)

  bs4Dash::dropdownMenuOutput(ns("profile"))

}

#' @rdname userLogoutModule
#' @importFrom shinydashboard dropdownMenu renderMenu notificationItem
#' @export
userLogoutModule <- function(input, output, session, username = "unknown"){


  output$profile <- bs4Dash::renderMenu({
    bs4Dash::dropdownMenu(type = "notifications",
                                 icon =  shiny::icon("user"),
                                 headerText = "Profiel",
                                 badgeStatus = NULL,
                                 bs4Dash::notificationItem(
                                   text = glue::glue("Ingelogd als {username}"),
                                   icon("user")
                                 ),
                                bs4Dash::notificationItem(
                                  text = "Druk op F5 om de applicatie te herladen", icon = shiny::icon("sync")
                                ),
                                bs4Dash::notificationItem(
                                  text = "Sluit het tabblad om de applicatie te sluiten", icon = shiny::icon("window-close")
                                )
    )
  })


}
