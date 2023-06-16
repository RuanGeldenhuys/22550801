plotPolar <- function(merged){
    df <- merged %>%
        mutate(year = year(release_date)) %>%
        mutate(year_group = cut(year, breaks = seq(min(year), max(year)+5, 5)))

    # Perform the min-max scaling
    df_scaled <- df %>%
        mutate(across(acousticness:valence, ~ ( .- min(.)) / (max(.) - min(.))))

    colnames(df_scaled)[6:14] = c('A','D','E','I','Li','Lo','S','T','V')

    df_summary <- df_scaled %>%
        mutate(year = year(release_date)) %>%
        mutate(year_group = cut(year, breaks = seq(min(year), max(year)+5, 5))) %>%
        group_by(band, year_group) %>%
        summarise(across(A:V, mean, na.rm = TRUE), .groups = "drop") %>%
        filter(!is.na(year_group))


    df_long<- df_summary %>%
        pivot_longer(cols = c(A:V), names_to = "quality", values_to = "mean")


    g1 <- df_long %>%
        ggplot(aes(x=quality,y=mean, fill = band))+
        geom_bar(stat = 'identity', position = 'dodge')+
        coord_polar(start = 0)+
        labs(x='',y='',title = 'Breakdown of Average Song Charateristics',
             subtitle = '5 Year periods', fill = 'Band', caption = 'V = Valence, A = Acousticness, D = Danceability
         E = Energy, I = Instrumentalness, Li = Liveness
         Lo = Loudness, S = Speechiness, T = Tempo')+
        theme(legend.position = c(0.85,0.2))+
        scale_fill_brewer(palette = "Set1")+
        facet_wrap(~year_group)
    g1
}




