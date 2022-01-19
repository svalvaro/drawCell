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
        )

    ),
    dashboardSidebar(width = 300,


        textInput(
            inputId = 'taxIdInput',
            label = h3('Introduce the species name or Taxonomy ID'),
            value = "",
            placeholder = "Homo sapiens / 6096"
        ),

        uiOutput('subCellSelector'),

        colourpicker::colourInput(inputId = "colourInput",
                                  h3("Select colour:"),
                                  '#56B4E9',
                                  palette = "square",
                                  returnName = TRUE,
                                  showColour = c("background")),

        shiny::sliderInput(
            inputId = 'cellSize',
            label = h3('Size of the cell'),
            min = 1,
            max = 5000,
            value = 2000
        ),

        br(),

        actionBttn(
            inputId = 'drawCell',
            label = 'Draw the cell!',
            icon = NULL,
            style = "unite",
            color = "default",
            size = 'md',
            block = FALSE,
            no_outline = TRUE
        )
        ),

    dashboardBody(
        box(
            imageOutput('cellImage')
        )
    )
)
