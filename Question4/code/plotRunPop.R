plotRunPop <- function(TitlesDF){
    suppressMessages({
        suppressWarnings({
            df <- TitlesDF %>%
                filter(!is.na(runtime)) %>%
                filter(!is.na(tmdb_popularity))


            ggplot(df, aes(x = type, y = runtime)) +
                geom_point(aes(color = type, size = tmdb_popularity)) +
                scale_size(range = c(1,10)) +
                labs(x = "", y = "Runtime", color = "Type",
                     title = 'Runtime vs Popularity',
                     caption = 'Source: Netflix & TMDB', size = 'TMDB Popularity') +
                theme_bw()
        })
    })
}


