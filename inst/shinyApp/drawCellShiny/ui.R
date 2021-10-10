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

        uiOutput('subCellSelector'),

        uiOutput('imageSize')
    ),
    dashboardBody(
        box(
            imageOutput('cellImage')
        )
    )
)
