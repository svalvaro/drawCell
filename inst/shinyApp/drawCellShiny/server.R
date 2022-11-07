function(input, output) {
  taxonomy_id <- reactive({
    if (input$cell_type == "") {
      if (is.na(as.numeric(input$taxIdInput))) {
        taxonomy_id <- taxize::get_ids(
          sci_com = input$taxIdInput,
          db = "ncbi"
        )

        taxonomy_id <- as.numeric(taxonomy_id$ncbi[1])
      } else {
        taxonomy_id <- as.numeric(input$taxIdInput)
      }
    } else {
      taxonomy_id <- data[which(data$Image.name == input$cell_type), ]$TaxID
    }
    return(taxonomy_id)
  })

  sc_id <- reactiveVal()

  subcellular_colours <- reactiveVal(list("SL0000" = "#56B4E9"))

  colors_table <- reactiveVal()

  drawcell_plot <- reactive({
    drawCell(
      organism_identifier = taxonomy_id(),
      list_sl_colors = subcellular_colours()
    )
  })

  output$cell_output <- drawCell:::renderDrawCell({
    drawcell_plot()
  })

  observeEvent(input$cell_click, {
    req(input$cell_click)
    req(input$colourInput)

    sc_id(substr(input$cell_click, 3, 6))

    list_named_colours <- subcellular_colours()
    list_named_colours[[input$cell_click]] <- input$colourInput
    subcellular_colours(list_named_colours)
  })

  observeEvent(input$colourInput, {
    req(input$cell_click)
    req(input$colourInput)

    list_named_colours <- subcellular_colours()
    list_named_colours[[input$cell_click]] <- input$colourInput
    subcellular_colours(list_named_colours)
  })

  observeEvent(input$cell_type, {
    sc_id(NULL)
  })

  output$selected_cell_name <- renderText({
    input$cell_type
  })

  observeEvent(
    {
      input$colourInput
      input$cell_click
      subcellular_colours()
    },
    {
      req(input$colourInput)
      req(input$cell_click)
      req(subcellular_colours())

      if (length(subcellular_colours()) == 1 && names(subcellular_colours()) == "SL0000") {
        selected_sc <- data.frame()
      } else {
        selected_sc <- uniprot[
          uniprot$Subcellular.location.ID %in% gsub("SL", "SL-", names(subcellular_colours())),
          c("Subcellular.location.ID", "Name")
        ]

        sc_colors <-
          glue::glue(
            "<div class='ui label'
            style='visibility: visible;
            color: white;
            background-color: {subcellular_colours()}'>
            {subcellular_colours()}
            </div>"
          )

        names(sc_colors) <- gsub("SL", "SL-", names(subcellular_colours()))
        selected_sc$Color <- sc_colors[selected_sc$Subcellular.location.ID]
        selected_sc <- selected_sc[, c("Name", "Color")]
      }

      output$cell_sl_color <-
        DT::renderDataTable({
          semantic_DT(
            selected_sc,
            colnames = c("Subcellular Name", "Color"),
            escape = FALSE,
            options = list(
              searching = FALSE,
              paging = FALSE,
              info = FALSE,
              columnDefs = list(
                list(
                  className = "dt-center",
                  targets = "_all"
                )
              )
            )
          )
        })
    }
  )

  observeEvent(
    input$clear_color,
    {
      sc_id(NULL)
      subcellular_colours(list("SL0000" = "#56B4E9"))
      output$cell_sl_color <-
        DT::renderDataTable({
          semantic_DT(
            data.frame()
          )
        })
    }
  )


  observeEvent(input$cell_type, {
    sc_id(NULL)
    req(input$cell_type)
    # If the user want's to see a neuron cell, this will be produced by taxID = 6072 and SL = "SL0288",
    # However, if the user wants to see a muscle cell next, we need to clear the subcellular_colours list
    # otherwise the SL of the neuron will be there and we will fetch a neuron again.

    if (input$cell_type == "Animal cell") subcellular_colours(list("SL0073"  = "white"))
    if (input$cell_type == "Animal neuronal cell") subcellular_colours(list("SL0288"  = "white"))
    if (input$cell_type == "Animal epithelial cell") subcellular_colours(list("SL0038"  = "white"))
    if (input$cell_type == "Animal muscle cell") subcellular_colours(list("SL0315"  = "white"))
    if (input$cell_type == "Animal photoreceptor cell") subcellular_colours(list("SL0458"  = "white"))
    if (input$cell_type == "Animal spermatozoa cell") subcellular_colours(list("SL0199"  = "white"))
    if (input$cell_type == "Animal egg cell") subcellular_colours(list("SL0540"  = "white"))
  })

  code_copy <- reactive({
    drawCell:::create_code_to_copy(taxonomy_id(), subcellular_colours())
  })

  output$copy_code <- renderUI({
    rclipboard::rclipButton(
      inputId = "clipbtn",
      label = "Copy the code to generate the cell",
      clipText = code_copy(),
      icon = icon("clipboard"),
      class = "ui basic fluid button"
    )
  })

  output$download_plot <- downloadHandler(
    filename = paste0(
      "cell",
      taxonomy_id(),
      format(Sys.time(), "%Y-%b-%d-%H:%M:%S"),
      ".png",
      collapse = "-"
    ),
    content = function(file) {
      svglite::svglite(file)
      drawcell_plot()
      dev.off()
    })
}
