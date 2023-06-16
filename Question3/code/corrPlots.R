popDF <- merged %>%
    select(popularity:valence, band)

df_split <- split(popDF, popDF$band)

cor_list <- map(df_split, ~ cor(.x[1:10]))   # Assuming columns 1 to 10 are the ones you want to correlate

# For Metallica
png("Metallica_corrplot.png")
c1 <-corrplot(cor_list[["Metallica"]],
         method = "color",
         title = "Correlation Matrix for Metallica",
         mar = c(0,0,1,0),
         type = 'lower')
dev.off()

# For Coldplay
png("Coldplay_corrplot.png")
corrplot(cor_list[["Coldplay"]],
         method = "color",
         title = "Correlation Matrix for Coldplay",
         mar = c(0,0,1,0),
         type = 'upper')
dev.off()


