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
  sc_id_to_select = reactiveVal()
  colours_vector = reactiveVal("#56B4E9")
  
  output$cell_output = drawCell::renderDrawCell({
    
    drawCell(taxonomy_id(),
             sc_id_to_select(),
             inputId = "cell",
             colour_sl = colours_vector())
  })

  observeEvent(input$cell_click,{
    sc_id(substr(input$cell_click, 3, 6))
    sc_id_to_select(c(sc_id_to_select(), input$cell_click))
    colours_vector(c(colours_vector(), input$colourInput))
  })
  
  observeEvent(input$cell_type, {
    sc_id(NULL)
    sc_id_to_select('SL0000')
  })
  
  output$cell_s_output <- renderText({
    sc_id_value = sc_id()
    if (!is.null(sc_id_value)) {
      find_sc(sc_id_value)
    } else {
      ""
    }
  })
}
