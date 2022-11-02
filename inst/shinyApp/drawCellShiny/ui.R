dashboardPage(
    dashboardHeader(
        title =  titlePanel(
            title = h2('drawCell'),

            windowTitle = tags$head(
                tags$link(
                    rel = "icon",
                    type = "image/png",
                    href = "favicon.ico"
                ),
                tags$title("drawCell")
            )
        ),
        tags$li(a(
            href = 'https://github.com/svalvaro/drawCell',
            icon("power-off"),
            title = "Close drawCell"),
            class = "dropdown")
    ),
    dashboardSidebar(width = 300,

        textInput(
            inputId = 'taxIdInput',
            label = h3('Introduce the species name or Taxonomy ID'),
            value = "",
            placeholder = "Homo sapiens / 6096"
        ),

        colourpicker::colourInput(inputId = "colourInput",
                                  h3("Select colour:"),
                                  '#56B4E9',
                                  palette = "square",
                                  returnName = TRUE,
                                  showColour = c("background")),

        selectInput("cell_type",
                    h3("Type of cell:"),
                    choices = c("",unique(data$Image.name))
                    )
        ),

    dashboardBody(
      drawCell:::drawCellOutput("cell_output"),
      wellPanel(
        textOutput("cell_s_output")
      )
    )
)
