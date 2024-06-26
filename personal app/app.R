library(shiny)
library(tidyverse)
community <- read_csv("Community.csv")
community_data <- community %>% select(-c("episode_num"))

ui <- fluidPage(
  titlePanel("Find Episode Details"),
  sidebarLayout(
    sidebarPanel(
      selectInput("season", "Select Season Number:",
                  choices = unique(community_data$season)),
      uiOutput("episode_select")
    ),
    mainPanel(
      h4("Episode Details:"),
      verbatimTextOutput("episode_details")
    )
  )
)

server <- function(input, output, session) {
  output$episode_select <- renderUI({
    episode_choices <- community_data %>%
      filter(season == input$season) %>%
      pull(episode_num_in_season) %>%
      sort()
    
    selectInput("episode_num_in_season", "Select Episode Number:",
                choices = episode_choices)
  })
  
  output$episode_details <- renderText({
    episode_details <- community_data %>%
      filter(season == input$season, episode_num_in_season == input$episode_num_in_season) %>%
      slice(1)
    
    if (nrow(episode_details) == 0) {
      "Episode not found."
    } else {
      viewership <- ifelse(is.na(episode_details$us_viewers), "NA", episode_details$us_viewers)
      
      paste("Season:", input$season, "\n",
            "Episode Number:", input$episode_num_in_season, "\n",
            "IMDb Rating:", episode_details$imdb_rating, "\n",
            "Viewership:", viewership, "\n",
            "Title:", episode_details$title, "\n",
            "Directed by:", episode_details$directed_by, "\n",
            "Description:", episode_details$desc)
    }
  })
}


shinyApp(ui = ui, server = server)

