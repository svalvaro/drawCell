dashboardPage(
    dashboardHeader(
        title = h3('drawCell')
    ),
    dashboardSidebar(width = 300,


        textInput(
            inputId = 'taxIdInput',
            label = 'Introduce the taxonomy ID',
            value = "",
            placeholder = "6096"
        ),

        # shinyWidgets::searchInput(
        #     inputId = "taxIdInput",
        #     label = "Introduce the taxonomy ID or Species name",
        #     placeholder = "6096 or Homo sapiens",
        #     btnSearch = icon("search"),
        #     btnReset = icon("remove"),
        #     width = "100%"
        # ),



        uiOutput('subCellSelector'),

        uiOutput('imageSize'),

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
