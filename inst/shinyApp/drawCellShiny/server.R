function(input, output){
  
  taxonomy_id <- reactive({
    if (input$cell_type == "") {
      
      if (is.na(as.numeric(input$taxIdInput))) {
        
        taxonomy_id <- taxize::get_ids(
          sci_com = input$taxIdInput,
          db = 'ncbi'
        )
        
        taxonomy_id <- as.numeric(taxonomy_id$ncbi[1])
      }else{
        taxonomy_id <- as.numeric(input$taxIdInput)
      }
    } else {
      taxonomy_id <- data[which(data$Image.name == input$cell_type), ]$TaxID
    }
    return(taxonomy_id)
  })
  
  sc_id = reactiveVal()

  subcelular_colours <- reactiveVal(list("SL0000" = "#56B4E9"))

  output$cell_output = drawCell:::renderDrawCell({
    
    drawCell(organism_identifier = taxonomy_id(),
             list_sl_colors = subcelular_colours())
  })

  observeEvent(input$cell_click,{
    sc_id(substr(input$cell_click, 3, 6))
    
    list_named_colours <- c(subcelular_colours(), input$colourInput)
    names(list_named_colours)[length(list_named_colours)] <- input$cell_click
    subcelular_colours(list_named_colours)
  })
  
  observeEvent(input$colourInput,{
    list_named_colours <- subcelular_colours()
    list_named_colours[length(list_named_colours)] <- input$colourInput
    subcelular_colours(list_named_colours)
  })

  observeEvent(input$cell_type, {
    sc_id(NULL)
  })
  
  output$cell_s_output <- renderText({
    sc_id_value = sc_id()
    if (!is.null(sc_id_value)) {
      drawCell:::find_sc(sc_id_value)
    } else {
      ""
    }
  })
}
