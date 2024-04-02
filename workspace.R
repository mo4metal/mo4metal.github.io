library(readr)

data1 <- read_csv("community_episodes.csv")
data2 <- read_csv("community_imdb.csv")
merged_data <- merge(data1, data2)
write.csv(merged_data, "Community.csv")




