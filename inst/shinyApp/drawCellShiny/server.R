function(input, output){



    subCellIds <-  readr::read_csv(base::system.file(
        'shinyApp/drawCellShiny/www/SLids.csv',
        package = 'drawCell')
        )


    # taxonomyId <- eventReactive(input$drawCell, {
    #
    #     if (is.null(input$taxIdInput)) {
    #         return(NULL)
    #     }
    #
    #     # IF the user provides a number ( the taxonomy id itself)
    #     if (!is.na(as.numeric(input$taxIdInput))) {
    #         taxonomyId <- input$taxIdInput
    #         return(taxonomyId)
    #     }
    #
    #     if (is.character(input$taxIdInput)) {
    #
    #         taxonomyId <- taxize::get_ids(
    #             sci_com = input$taxIdInput,
    #             db = 'ncbi'
    #         )
    #
    #         taxonomyId <- taxonomyId$ncbi[1]
    #
    #         return(taxonomyId)
    #
    #     }
    #
    #     message(paste0('The taxonomy is', taxonomyId))
    #
    #
    # })

#
#
#     taxonomyId <- reactiveValues()
#
#
#     observeEvent(input$drawCell,{
#
#             # IF the user provides a number ( the taxonomy id itself)
#             if (!is.na(as.numeric(input$taxIdInput))) {
#                 taxonomyId$ID <- input$taxIdInput
#                 return(taxonomyId)
#             }
#
#             if (is.character(input$taxIdInput)) {
#
#                 taxonomyId <- taxize::get_ids(
#                     sci_com = input$taxIdInput,
#                     db = 'ncbi'
#                 )
#
#                 taxonomyId$ID <- taxonomyId$ncbi[1]
#
#                 return(taxonomyId)
#
#             }
#     })



    output$subCellSelector <- renderUI({

        shinyWidgets::pickerInput(
                inputId = "subIdsSelected",
                label = "Select/deselect all options",
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

    output$imageSize <- renderUI({

        shiny::sliderInput(
            inputId = 'cellSize',
            label = 'Size of the cell',
            min = 1,
            max = 5000,
            value = 2000
        )
    })


    subCellIdsSelected <- eventReactive(input$drawCell,{

        subCellIdsSelected <- subCellIds$SubCell.Id[
            base::match(
                x = input$subIdsSelected,
                table = subCellIds$Location)]

    })



    observeEvent(input$drawCell,{

        output$cellImage <-     renderPlot(width = input$cellSize,{

            if (is.null(input$taxIdInput)) {
                return(NULL)
            }

            drawCell::drawCell(
                organism_identifier =  input$taxIdInput,
                sl_ids = subCellIdsSelected(),
                color = 'green',
                size = input$cellSize,
                delay = 2

            )


        })
    })







}
