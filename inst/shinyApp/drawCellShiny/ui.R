semanticPage(
  includeCSS("www/styles.css"),
  # Application title
  titlePanel(
    title = div(
      class = "ui massive fluid teal right icon label",
      "drawCell | Easily obtain nice cell pictures in R",
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
        class = "ui horizontal stackable segments centered_content",
        segment(
          class = "compact padded",
          selectInput(
            inputId = "cell_type",
            label = label(
              class = "big teal pointing below",
              "Cell Type"
            ),
            choices = c("", sort(unique(data$Image.name))),
            selected = "Animal cell",
            type = "big search clearable selection"
          )
        ),
        segment(
          class = "compact padded",
          div(class = "ui vertical divider", "OR")
        ),
        segment(
          class = "compact padded",
          text_input(
            input_id = "taxIdInput",
            label = label(
              class = "big teal pointing below",
              "Species name/Taxonomy ID"
            ),
            value = "",
            placeholder = "Homo sapiens / 6096"
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
          class = "padded compact",
          div(
            class = "ui vertical compact segments",
            segment(
              class = "compact padded",
              colourpicker::colourInput(
                inputId = "colourInput",
                label = label(
                  class = "big teal pointing below",
                  "Color Subcellular Location"
                ),
                "#56B4E9",
                palette = "square",
                returnName = TRUE,
                showColour = c("background")
              ),
              button(
                input_id = "clear_color",
                class = "big basic",
                label = "Clear Colors"
              )
            ),
            segment(
              class = "compact padded",
              semantic_DTOutput("cell_sl_color")
            )
          )
        ),
        segment(
          class = "padded",
          drawCell:::drawCellOutput("cell_output", height = "100%", width = "100%")
        )
      )
    )
  )
)
