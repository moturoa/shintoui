![](https://badgen.net/badge/shintolabs/utility/purple)
# shintoui: all the UI choices for Shinto apps


## Installation

```
devtools::install_github("moturoa/shintoui")
```

## Example

A complete [example application can be found from this link]().


## Using shintoui

- **Do not load** `shinydashboard` or `shinydashboardPlus`, or use any functions from them via `::` !
- Use the following functions in `shintoui` **only**, instead of equivalents in those packages:

`shintoui::box`
`shintoui::tab_box`
`shintoui::tab_panel`
`shintoui::tab_items`
`shintoui::tab_item`
`shintoui::dashboard_page`
`shintoui::dashboard_sidebar`
`shintoui::sidebar_menuoutput`
`shintoui::render_menu`
`shintoui::sidebar_menu`
`shintoui::dashboard_sidebar`

- Instead of the usual `dashboardHeader`, use the function `shintoui::dashboard_header`.  This function includes many features, including

  - Dropdown menu with application information (using `shintoshiny::appInfoUI`)
  - Link to Shinto support page
  - Dropdown menu with user logout button, 'currently logged in as'.
  - A clock in the header (just left of the buttons to the right)
  - A 'tag line' argument, to display text just right of the menu in the header.

- To use the header, and fill application information, etc. use this line in the server function:

```
shintoui::populate_header(username = shintoshiny::get_user(default = "devuser"))
```

In your application, choose a sensible app user name (for example 'wbm_dev', 'linkit_dev'), not your own name.

- For a Dutch `datatable` with bootstrap 4 setttings, use `shintoshiny::datatafel` instead of `datatable`. 

- You can still use shiny page elements, including: `column`, `fluidRow`, `actionButton`, and so on. Just don't use anything from `shinydashboard` or `shinydashboardPlus` - there are many CSS conflicts which will mess up the UI completely.



## Contact

Remko Duursma


