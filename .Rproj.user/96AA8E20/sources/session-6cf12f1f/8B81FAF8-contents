
library(tidyverse)
community <- read_csv("Community.csv")
community_data <- community %>% select(-c("episode_num"))
library(shiny)

ui <- fluidPage(
  titlePanel("Community Viewership Trends per Season"),
  sidebarLayout(
    sidebarPanel(
      selectInput("season", "Select Season:",
                  choices = unique(community_data$season))  
    ),
    
    mainPanel(
      plotOutput("linePlot")
    )
  )
)

server <- function(input, output) {
  selected_season <- reactive({
    filter(community_data, season == input$season)
  })
  
  
  output$linePlot <- renderPlot({
    ggplot(selected_season(), aes(x = episode_num_in_season, y = us_viewers)) +
      geom_line(color = "blue") +
      geom_point(color = "red", size = 1) +  
      labs(title = paste("Viewership Trend for Season", input$season),
           x = "Episode Number",
           y = "Viewership") +
      scale_x_continuous(breaks = selected_season()$episode_num_in_season, 
                         labels = selected_season()$episode_num_in_season) +
      theme_minimal() +  
      scale_y_continuous(labels = scales::comma)
  })
}

shinyApp(ui = ui, server = server)
