#' Browser/navigator info dependencies
#' @description In the UI, place the command \code{shintoui::shintoui_dependencies()}.
#' @export
shintoui_dependencies <- function() {

  list(
    htmltools::htmlDependency(name = "clock", version = "0.1",
                              package = "shintoui",
                              src = "assets",
                              script = "clock/clock.js"
    )
  )
}


