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
    sc_id_to_select(c(sc_id_to_select(),  input$cell_click))
    colours_vector(c(colours_vector(), input$selected_sub_cell_color))
  })

  observeEvent(input$selected_cell, {
    sc_id(NULL)
    sc_id_to_select("SL0000")
  })

  output$cell_sl_name <- renderText({
    sc_id_value <- sc_id()
    if (!is.null(sc_id_value)) {
      find_sc(sc_id_value)
    } else {
      ""
    }
  })

  output$download <- downloadHandler(
    filename = function() {
      paste("cell-", taxonomy_id(), ".png")
    },
    content = function(file) {
      jpeg(file, quality = 100, width = 800, height = 800)
      rendered_cell_svg()
      dev.off()
    }
  )
}
