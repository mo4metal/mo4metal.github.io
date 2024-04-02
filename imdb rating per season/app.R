
library(tidyverse)
community <- read_csv("Community.csv")
community_data <- community %>% select(-c("episode_num"))
library(shiny)

season_colors <- c("1" = "blue",
                   "2" = "green",
                   "3" = "red",
                   "4" = "orange",
                   "5" = "purple",
                   "6" = "black")

ui <- fluidPage(
  titlePanel("IMDb Ratings for Community Episodes"),
  sidebarLayout(
    sidebarPanel(
      selectInput("season", "Select Season:",
                  choices = c("1", "2", "3", "4", "5", "6"),
                  selected = "1")
    ),
    mainPanel(
      plotOutput("scatter_plot")
    )
  )
)


server <- function(input, output) {
  output$scatter_plot <- renderPlot({
    season_data <- subset(community_data, season == input$season)
    
    ggplot(season_data, aes(x = episode_num_overall, y = imdb_rating)) +
      geom_point() +
      scale_color_manual(values = season_colors) +
      labs(x = "Episode", 
           y = "IMDb Rating", 
           title = paste("IMDb Ratings for Community episodes (Season", input$season, ")")) +
      scale_x_continuous(breaks = season_data$episode_num_overall, 
                         labels = season_data$episode_num_overall) +  
      theme(plot.margin = margin(r = 2, unit = "cm"))
    
  })
}

shinyApp(ui = ui, server = server)