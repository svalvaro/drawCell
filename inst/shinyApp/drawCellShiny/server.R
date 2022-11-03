function(input, output) {
  taxonomy_id <- reactive({
    if (input$selected_cell == "") {
      if (is.na(as.numeric(input$cell_taxonomy_id))) {
        taxonomy_id <- taxize::get_ids(
          sci_com = input$cell_taxonomy_id,
          db = "ncbi"
        )

        taxonomy_id <- as.numeric(taxonomy_id$ncbi[1])
      } else {
        taxonomy_id <- as.numeric(input$cell_taxonomy_id)
      }
    } else {
      taxonomy_id <- data[which(data$Image.name == input$selected_cell), ]$TaxID
    }
    return(taxonomy_id)
  })

  sc_id <- reactiveVal()
  sc_id_to_select <- reactiveVal()
  colours_vector <- reactiveVal("#56B4E9")
  rendered_cell_svg <- reactiveVal()

  output$cell_output <- renderDrawCell({
    drawn_cell <- drawCell(
      organism_identifier = taxonomy_id(),
      sl_ids = sc_id_to_select(),
      inputId = "cell",
      colour_sl = colours_vector()
    )

    rendered_cell_svg(drawn_cell)

    drawn_cell
  })

  observeEvent(input$cell_click, {
    sc_id(substr(input$cell_click, 3, 6))
    sc_id_to_select(c(sc_id_to_select(), input$cell_click))
    colours_vector(c(colours_vector(), input$selected_sub_cell_color))
  })

  observeEvent(input$selected_cell, {
    sc_id(NULL)
    sc_id_to_select("SL0000")
  })

  output$selected_cell_name <- renderText({
    input$selected_cell
  })

  output$cell_sl_color <-
    DT::renderDataTable({
      req(sc_id_to_select() > 1)

      if (length(sc_id_to_select()) == 1 && sc_id_to_select() == "SL0000") {
        selected_sc <- data.frame()
      } else {
        selected_sc <- uniprot[
          uniprot$Subcellular.location.ID %in% gsub("SL", "SL-", sc_id_to_select()),
          c("Subcellular.location.ID", "Name")
        ]

        sc_colors <-
          # By default, SL0000 will have the first default color, so this must be removed
          # since SL0000 does not need to and will not be displayed in the table anyway.
          glue::glue(
            "<i class='square icon' style='visibility: visible; color: {colours_vector()[-1]}'></i>"
          )

        names(sc_colors) <- gsub("SL", "SL-", sc_id_to_select())[-1]

        selected_sc$Colors <- sc_colors[selected_sc$Subcellular.location.ID]
      }

      semantic_DT(
        selected_sc,
        colnames = c("Subcellular Location ID", "Subcellular Name", "Color"),
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
