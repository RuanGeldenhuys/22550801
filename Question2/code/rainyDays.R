rainyTable <- function(dat){
    #From: https://www.places.co.za/info/general/south-africa-climate-monthly-temp-rainfall-chart.html
    rainy_days_CPT <- c(3,2,3,4,7,9,9,9,7,6,5,4)

    tableDF <- dat %>%
        filter(!is.na(precipitation)) %>%
        mutate(rainy = ifelse(precipitation > 0, 1, 0))

    df_modified <- tableDF %>%
        group_by(month) %>%
        summarise(rainy_days_UK = round(mean(rainy, na.rm = TRUE)*30,1), .groups = "drop") %>%
        cbind(rainy_days_CPT)

    raintable <- xtable(df_modified, caption = "London vs Cape Town rain days")
    colnames(raintable) <- c('Month', 'Rainy Days (UK)', 'Rainy Days (CPT)')
    return(raintable)
}




