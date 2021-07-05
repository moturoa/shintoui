#' Write header information
#' @description Writes logout menu, app info menu, etc.
#' @param username Current username (for logout menu)
#' @export
populate_header <- function(username){

  callModule(username_module, "shintoui", username = username)

  callModule(shintoshiny::appInfoModule, "appinfo")

}

username_module <- function(input, output, session, username = "unknown"){

  output$txt_username <- renderText({
    paste("Ingelogd als:", username)
  })

}

