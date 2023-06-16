mergeBands <- function(coldplay, metallica){
    coldplay2 <- coldplay %>%
        filter(!grepl('Live', .$name)) %>%
        mutate(band = 'Coldplay') %>%
        select(-explicit) %>%
        rename(album = album_name)

    combinedDF <- metallica %>%
        filter(!grepl('Live', .$name)) %>%
        mutate(band = 'Metallica') %>%
        mutate(duration = duration_ms/1000) %>%
        select(-duration_ms) %>%
        select(colnames(coldplay2)) %>%
        rbind(coldplay2)

    songsDF <- combinedDF %>%
        group_by(release_date, band) %>%
        summarise(songs = n()) %>%
        mutate(release_date = as.Date(release_date)) %>%
        mutate(year = year(release_date))
    return(songsDF)
}


songreleases_plot <- function(mergedDF){
    songsDF <- mergedDF
    all_years <- data.frame(year = min(songsDF$year):max(songsDF$year))
    all_bands <- unique(songsDF$band)
    completeCombined <- expand_grid(band = all_bands, year = all_years$year) %>%
        left_join(songsDF %>%
                      group_by(band, year) %>%
                      summarise(songs = sum(songs)),
                  by = c("band", "year")) %>%
        replace_na(list(songs = 0)) %>%
        arrange(band, year)

    total_songs <- completeCombined %>%
        group_by(band) %>%
        summarise(total = sum(songs))


    g1<- ggplot(data = completeCombined, aes(x = year, y = songs, fill = band)) +
        geom_bar(stat = "identity", position = "dodge", color = 'black') +
        theme_bw() +
        scale_fill_brewer(palette = "Set1")+
        geom_text(data = total_songs,
                  aes(x = median(completeCombined$year)-4, y = c(120,130),
                      label = paste("Total songs,",band,":", total)),
                  hjust = -0.1) +
        labs(x = "Year", y = "Number of Songs",
             title = "Number of Songs Produced per Year",
             fill = "Band",
             caption = 'Source: Spotify')+
        theme(legend.position = 'bottom')
    return(g1)
}

