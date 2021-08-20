
#' Shiny module for a plot and the data in a tab box
#' @rdname plotBox
#' @export
plotBoxUI <- function(id, title = "", ...){

  ns <- NS(id)

  shintoui::tab_box(title = title, ...,

      shintoui::tab_panel(bsicon("file-bar-graph"),
        plotOutput(ns("plot"))
      ),
      shintoui::tab_panel(bsicon("table"),
        tableOutput(ns("table"))
      )

  )

}

#' @rdname plotBox
plotBox <- function(input, output, session,
                    data = reactive(NULL),
                    plot_function = function(data)NULL,
                    table_function = function(data)data,
                    digits = 0, align = 'l', striped = TRUE){


  output$plot <- renderPlot({
    plot_function(data())
  })

  output$table <- renderTable({
   table_function(data())
  }, digits = digits, align = align, striped = striped)

}

