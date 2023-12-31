library(shiny)      # v1.7.5
library(ggplot2)    # v3.4.3
library(bslib)      # v0.5.1
library(gridlayout) # [github::rstudio/gridlayout] v0.2.1

ui <- page_navbar(
  title = "Chick Weights Dashboard",
  selected = "Line Plots",
  collapsible = TRUE,
  theme = bslib::bs_theme(preset = "minty"),
  tabPanel(
    title = "Line Plots",
    grid_container(
      row_sizes = c(
        "1fr"
      ),
      col_sizes = c(
        "250px",
        "1fr"
      ),
      gap_size = "10px",
      layout = c(
        "num_chicks linePlots"
      ),
      grid_card(
        area = "num_chicks",
        card_header("Settings"),
        card_body(
          sliderInput(
            inputId = "numChicks",
            label = "Number of chicks",
            min = 1,
            max = 15,
            value = 5,
            step = 1,
            width = "100%"
          ),
          h2(em("Demo Data Wizard"))
        )
      ),
      grid_card_plot(area = "linePlots")
    )
  ),
  tabPanel(
    title = "Distributions",
    grid_container(
      row_sizes = c(
        "165px",
        "1fr"
      ),
      col_sizes = c(
        "1fr"
      ),
      gap_size = "10px",
      layout = c(
        "facetOption",
        "dists"
      ),
      grid_card_plot(area = "dists"),
      grid_card(
        area = "facetOption",
        card_header("Distribution Plot Options"),
        card_body(
          radioButtons(
            inputId = "distFacet",
            label = "Facet distribution by",
            choices = list("Diet Option" = "Diet", "Measure Time" = "Time")
          )
        )
      )
    )
  )
)


server <- function(input, output) {

  output$linePlots <- renderPlot({
    obs_to_include <- as.integer(ChickWeight$Chick) <= input$numChicks
    chicks <- ChickWeight[obs_to_include, ]

    ggplot(
      chicks,
      aes(
        x = Time,
        y = weight,
        group = Chick
      )
    ) +
      geom_line(alpha = 0.5) +
      ggtitle("Chick weights over time")
  })

  output$dists <- renderPlot({
    ggplot(
      ChickWeight,
      aes(x = weight)
    ) +
      facet_wrap(input$distFacet) +
      geom_density(fill = "#fa551b", color = "#ee6331") +
      ggtitle("Distribution of weights by diet")
  })

}

shinyApp(ui, server)
