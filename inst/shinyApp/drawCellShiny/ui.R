semanticPage(
  includeCSS("www/styles.css"),
  # Application title
  titlePanel(
    title = a(
      class = "ui huge teal label",
      "drawCell",
      href = "https://github.com/svalvaro/drawCell",
      target = "_blank"
    )
  ),
  div(
    class = "ui segments",
    segment(
      class = "padded",
      div(
        class = "ui horizontal stackable segments",
        segment(
          class = "padded",
          text_input(
            input_id = "cell_taxonomy_id",
            label = label(
              class = "teal pointing below",
              "Introduce the species name or Taxonomy ID"
            ),
            value = "",
            placeholder = "Homo sapiens / 6096"
          )
        ),
        segment(
          class = "padded",
          selectInput(
            inputId = "selected_cell",
            label = label(class = "teal pointing below", "Select Cell"),
            choices = c("", sort(cell_name)),
            selected = "Animal cell",
            type = "big search clearable selection"
          )
        ),
        # segment(
        #   class = "padded",
        #   selectInput(
        #     inputId = "selected_sub_cell",
        #     label = label("Select Cell Subsstructure (ID)", class = "teal pointing below"),
        #     choices = sort(sub_cell_ids$location_id),
        #     selected = "Nucleus (0191)",
        #     type = "clearable multiple search selection"
        #   )
        # ),
        segment(
          class = "padded",
          colourpicker::colourInput(
            inputId = "selected_sub_cell_color",
            label = label("Select color", class = "teal pointing below"),
            "#56B4E9",
            palette = "square",
            returnName = TRUE,
            showColour = c("background")
          )
        )
      )
    ),
    segment(
      class = "raised very padded container",
      label(textOutput("cell_sl_name"), class = "big teal top left attached"),
      drawCellOutput("cell_output", height = "auto", width = "auto"),
      semantic_DTOutput("cell_sl_color"),
      absolutePanel(
        div(
          class = "ui stackable basic icon huge buttons",
          downloadButton(outputId = "download", label = "", class = "ui button", icon = icon("download"))
        ),
        top = 10, right = 10
      )
    )
  )
)
