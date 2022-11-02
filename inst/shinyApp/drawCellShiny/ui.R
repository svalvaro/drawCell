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
        )
      )
    ),
    segment(
      class = "raised very padded container",
      label(textOutput("selected_cell_name"), class = "big teal top left attached"),
      div(
        class = "ui horizontal stackable segments",
        segment(
          class = "padded",
          drawCellOutput("cell_output", height = "auto", width = "auto")
        ),
        segment(
          class = "padded",
          div(
            class = "ui vertical segments",
            segment(
              class = "padded",
              colourpicker::colourInput(
                inputId = "selected_sub_cell_color",
                label = label(
                  class = "teal pointing below",
                  "Select color then cell subsstructure to highlight"
                ),
                "#56B4E9",
                palette = "square",
                returnName = TRUE,
                showColour = c("background")
              )
            ),
            segment(
              class = "padded",
              semantic_DTOutput("cell_sl_color")
            )
          )
        )
      )
    )
  )
)
