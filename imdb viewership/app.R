library(tidyverse)
library(shiny)
library(plotly)

community_data <- read_csv("Community.csv")

ui <- fluidPage(
  titlePanel("Relationship between IMDb Rating and Viewership by Season"),
  sidebarLayout(
    sidebarPanel(
      selectInput("season", "Select Season:",
                  choices = unique(community_data$season))
    ),
    mainPanel(
      plotlyOutput("scatterPlot")
    )
  )
)

server <- function(input, output) {
  
  output$scatterPlot <- renderPlotly({
    season_data <- community_data %>%
      filter(season == input$season)
    
   
    p <- ggplot(season_data, aes(x = us_viewers, y = imdb_rating)) +
      geom_point(color = "skyblue", size = 1.5) +
      labs(title = paste("Relationship between IMDb Rating and Viewership", input$season),
           x = "Viewership",
           y = "IMDb Rating") +
      theme_minimal() +
      scale_x_continuous(labels = scales::comma)
    
    
    p <- ggplotly(p)
    
    p <- style(p, hoverinfo = "text", text = paste("Episode:", season_data$episode_num_in_season))
    
    p
  })
}

shinyApp(ui = ui, server = server)