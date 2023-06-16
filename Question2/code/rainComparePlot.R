rainComparePlot <- function(dat){
    #From: https://www.places.co.za/info/general/south-africa-climate-monthly-temp-rainfall-chart.html
    rainy_days_CPT <- c(3,2,3,4,7,9,9,9,7,6,5,4)

    tableDF <- dat %>%
        filter(!is.na(precipitation)) %>%
        mutate(rainy = ifelse(precipitation > 0, 1, 0))

    df_modified <- tableDF %>%
        group_by(month) %>%
        summarise(rainy_days_UK = round(mean(rainy, na.rm = TRUE)*30,1), .groups = "drop") %>%
        cbind(rainy_days_CPT) %>%
        gather(key = "City", value = "Value", -month)

    g1 <- df_modified %>%
        ggplot(aes(x=month, y=Value, fill=City))+
        geom_bar(stat = 'identity', position = 'dodge')+
        theme_bw()+
        scale_fill_viridis(discrete = TRUE, labels=c('Cape Town', 'London'))+
        labs(title = 'London vs CPT - Rainy Days', x='Days', y='Month', caption =
                 'Sources: UK National Weather Service & Southern Africa Tourism Services Association')
    return(g1)

}
