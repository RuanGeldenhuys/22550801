plotPopularity <- function(TitlesDF){
    suppressMessages({
        suppressWarnings({
            df <- TitlesDF %>%
                group_by(release_year, type) %>%
                summarise(avgPopularity = mean(tmdb_popularity, na.rm = TRUE)) %>%
                filter(avgPopularity < 150) #remove outliers

            g1 <- df %>%
                ggplot(aes(x=release_year,y=avgPopularity, fill=type))+
                geom_point(aes(color = type))+
                geom_line(aes(color = type))+
                theme_bw() +
                labs(title = "Popularity: TV Shows vs Movies",
                     x = 'Release Year',
                     y = 'TMDB Popularity',
                     caption = 'Source: The Movie Database (TMDB)') +
                theme(legend.position = 'bottom',
                      legend.title = element_blank())
            g1
        })
    })

}

