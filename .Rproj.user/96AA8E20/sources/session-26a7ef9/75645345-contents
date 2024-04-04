
library(tidyverse)
community <- read_csv("Community.csv")
community_data <- community %>% select(-c("episode_num"))
library(shiny)

ui <- fluidPage(
  titlePanel("Relationship between IMDb Rating and Viewership by Season"),
  sidebarLayout(
    sidebarPanel(
      selectInput("season", "Select Season:",
                  choices = unique(community_data$season))
    ),
    mainPanel(
      plotOutput("scatterPlot")
    )
  )
)

server <- function(input, output) {
  
  output$scatterPlot <- renderPlot({
    season_data <- community_data %>%
      filter(season == input$season)
    ggplot(season_data, aes(x = us_viewers, y = imdb_rating)) +
      geom_point(color = "blue", size = 3) +
      labs(title = paste("Relationship between IMDb Rating and Viewership for Season", input$season),
           x = "Viewership",
           y = "IMDb Rating") +
      theme_minimal() +
      scale_x_continuous(labels = scales::comma)  
  })
}

shinyApp(ui = ui, server = server)
