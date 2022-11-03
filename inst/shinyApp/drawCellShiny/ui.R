semanticPage(
  includeCSS("www/styles.css"),
  # Application title
  titlePanel(
    title = div(
      class = "ui massive fluid teal right icon label",
      "drawCell",
      a(
        icon(class = "big github square"),
        href = "https://github.com/svalvaro/drawCell",
        target = "_blank"
      )
    )
  ),
  div(
    class = "ui attached segments",
    segment(
      class = "padded",
      div(
        class = "ui horizontal stackable segments",
        segment(
          class = "padded",
          text_input(
            input_id = "taxIdInput",
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
            inputId = "cell_type",
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
      label(textOutput("selected_cell_name"), class = "big teal top attached"),
      div(
        class = "ui horizontal stackable segments",
        segment(
          class = "compact padded",
          div(
            class = "ui action input",
            colourpicker::colourInput(
              inputId = "colourInput",
              label = label(
                class = "teal pointing below",
                "Select subcellular location to highlight then select color"
              ),
              "#56B4E9",
              palette = "square",
              returnName = TRUE,
              showColour = c("background")
            ),
            button(
              input_id = "clear_color",
              class = "basic",
              label = "Clear Colors"
            )
          )
        ),
        segment(
          class = "compact padded",
          div(
            class = "ui horizontal stackable segments",
            segment(
              class = "padded",
              drawCell:::drawCellOutput("cell_output", height = "auto", width = "auto")
            ),
            segment(
              class = "compact padded",
              semantic_DTOutput("cell_sl_color")
            )
          )
        )
      )
    )
  )
)
