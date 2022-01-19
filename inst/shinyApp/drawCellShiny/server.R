function(input, output){

    subCellIds <-  utils::read.csv(base::system.file(
        'shinyApp/drawCellShiny/www/SLids.csv',
        package = 'drawCell')
    )
    output$subCellSelector <- renderUI({

        shinyWidgets::pickerInput(
            inputId = "subIdsSelected",
            label = h3("Select the subcellular locations"),
            choices = subCellIds$Location,
            options = list(
                style = "btn-primary",
                `actions-box` = TRUE,
                `live-search` = TRUE),

            choicesOpt = list(
                subtext = paste("SL_id",
                                subCellIds$SubCell.Id,
                                sep = ": ")
            ),
            multiple = TRUE
        )

    })

    subCellIdsSelected <- eventReactive(input$drawCell,{

        subCellIdsSelected <- subCellIds$SubCell.Id[
            base::match(
                x = input$subIdsSelected,
                table = subCellIds$Location)]

    })

    pathToCellFile <- reactiveValues(path = NULL)

    observeEvent(input$drawCell,{

        pathToCellFile$path <- drawCell::drawCell(
                organism_identifier =  input$taxIdInput,
                sl_ids = subCellIdsSelected(),
                color = input$colourInput,
                size = input$cellSize,
                delay = 2,
                returnPlot = FALSE
            )

        print(paste0('The path to the file is:', pathToCellFile$path))
    })

    observeEvent(input$drawCell,{

        if (is.null(pathToCellFile$path)) {
            return(NULL)
        }

        output$cellImage <- renderPlot(width = input$cellSize, height = 1500,{

            cellPNG <- png::readPNG(source = pathToCellFile$path)

            message('Cell picture created: ', !is.null(cellPNG))

            return(
                grid::grid.raster(cellPNG)
            )
        })
    })


}
