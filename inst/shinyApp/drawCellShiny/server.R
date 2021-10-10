function(input, output){



    subCellIds <- subCellIds <- read.csv(
            base::system.file(
                'shinyApp/drawCellShiny/www/SLids.csv',
                package = 'drawCell'
            )
        )

    output$subCellSelector <- renderUI({

        shinyWidgets::pickerInput(
                inputId = "subIdsSelected",
                label = "Select/deselect all options",
                choices = subCellIds$Location,
                options = list(
                    `actions-box` = TRUE,
                    `live-search` = TRUE),
                multiple = TRUE
            )
        })

    output$imageSize <- renderUI({

        shiny::sliderInput(
            inputId = 'cellSize',
            label = 'Size of the cell',
            min = 1,
            max = 5000,
            value = 2000
        )
    })


    subCellIdsSelected <- reactive({

        subCellIdsSelected <- subCellIds$SubCell.Id[
            base::match(
                x = input$subIdsSelected,
                table = subCellIds$Location)]

    })


    output$cellImage <- renderImage({

        if (is.null(input$taxIdInput)) {
            return(NULL)
        }

        src = paste0(system.file('cell_pictures/',
                          package = 'drawCell'),'cell_pic.png')

        drawCell::drawCell(
            taxonomy_id = input$taxIdInput,
            sl_ids = subCellIdsSelected(),
            color = 'green',
            size = input$cellSize,
            pictureName = src
        )

        list(src = src)



    })
}
