makeGenreGif <- function(TitlesDF){
    suppressMessages({
        suppressWarnings({
            df <- TitlesDF
            df$genres <- sapply(df$genres, function(x) strsplit(gsub("^\\[|\\]$", "", x), ","))
            df <- tidyr::unnest(df, genres)

            df_grouped <- df %>%
                group_by(release_year, genres) %>%
                summarize(avg_popularity = mean(imdb_score, na.rm = TRUE)) %>%
                filter(release_year > 2005)

            df_spread <- df_grouped %>%
                spread(key = genres, value = avg_popularity, fill = 0)
            genres_every_year <- colnames(df_spread)[!apply(df_spread, 2, function(col) any(col == 0))]
            genres_every_year <- setdiff(genres_every_year, "release_year")


            wantedGenres <- genres_every_year[-15]   #Here we limit our genres and release years
            df_grouped <- df_grouped %>%             #to ensure that we don't have empty bars on
                filter(genres %in% wantedGenres)     #the final plot


            p <- ggplot(df_grouped, aes(x = genres, y = avg_popularity, fill = genres)) +
                geom_col(show.legend = FALSE) +
                labs(x = "Genre", y = "Average IMDB Rating", title = "Average IMDB Rating by Genre: {closest_state}") +
                theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

            anim <- p +
                transition_states(
                    release_year,
                    transition_length = 4,
                    state_length = 1
                )+
                ease_aes('cubic-in-out')
            return(anim)
        })
    })

}


