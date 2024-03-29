semanticPage(
  includeCSS("www/styles.css"),
  shinyjs::useShinyjs(),
  # Application title
  titlePanel(
    title = div(
      class = "ui massive fluid teal right icon label",
      id = "title_label",
      "drawCell",
      a(
        icon(class = "big github square"),
        href = "https://github.com/svalvaro/drawCell",
        target = "_blank"
      ),
      h2("App for creating cell pictures")
    )
  ),
  rclipboard::rclipboardSetup(),
  div(
    class = "ui attached segments no_box",
    segment(
      class = "padded no_box",
      div(
        class = "ui horizontal stackable segments centered_content",
        segment(
          class = "compact padded no_box min_width_input",
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
          class = "compact padded no_box",
          div(class = "ui vertical divider", "OR")
        ),
        segment(
          class = "compact padded no_box min_width_input",
          text_input(
            input_id = "taxIdInput",
            label = label(
              class = "big teal pointing below",
              "Species Name/Taxonomy ID"
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
        class = "ui horizontal stackable segments no_box",
        segment(
          class = "padded compact no_box",
          div(
            class = "ui vertical compact segments green_box",
            segment(
              class = "compact padded no_box",
              colourpicker::colourInput(
                inputId = "colourInput",
                label = "Select subcellular location to color",
                "#56B4E9",
                palette = "square",
                returnName = TRUE,
                showColour = c("background")
              ),
              br(),
              button(
                input_id = "clear_color",
                class = "big basic",
                label = "Clear Colors"
              )
            ),
            segment(
              class = "compact padded no_box",
              semantic_DTOutput("cell_sl_color")
            )
          )
        ),
        segment(
          class = "padded no_box",
          drawCell:::drawCellOutput("cell_output", height = "auto", width = "200%")
        )
      ),
      div(
        class = "ui horizontal segments no_box",
        segment(
          class = "compact padded no_box",
          div(
            class = "ui horizontal stackable segments no_box",
            segment(
              class = "compact padded no_box",
              uiOutput("copy_code")
            ),
            segment(
              class = "compact padded no_box",
              downloadButton(
                "download_cell",
                label = "Download Cell",
                icon = icon("download"),
                class = "basic"
              )
            )
          )
        )
      )
    ),
    segment(
      class = "compact padded right floated no_box",
      "Cell Images from ",
      a(
        "SwissBioPics API",
        href = "https://www.swissbiopics.org/",
        target = "_blank"
      ),
      style = "background: transparent;"
    )
  )
)
