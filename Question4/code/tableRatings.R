tableRatings <- function(TitlesDF, Latex = FALSE){
    df <- TitlesDF %>%
        group_by(age_certification) %>%
        summarise(avgScore = mean(imdb_score, na.rm = TRUE),
                  avgPop = mean(tmdb_popularity, na.rm = TRUE)) %>%
        filter(!row_number() == 1)
    colnames(df) <- c('Age Rating', 'Average IMDB score', 'Popularity')

    if (Latex) {
        ratingTable <- options(xtable.comment = FALSE)
        ratingTable <- xtable(df, caption = 'Age Ratings and Outcomes')
    } else{
        ratingTable <- knitr::kable(df, caption = 'Age Ratings and Outcomes')
    }

    return(ratingTable)
}

