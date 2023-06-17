downloadsTable <- function(appsDF, Latex = FALSE){
    df <- appsDF %>%
        mutate(Price = as.numeric(str_remove(Price, "\\$"))) %>%
        mutate(Installs = str_remove(Installs, "\\+")) %>%
        mutate(Installs = as.numeric(gsub(',','',Installs)))

    df <- df %>%
        mutate(Price_Range = case_when(
            Price == 0 ~ "0",
            Price > 0 & Price <= 5 ~ "0-5",
            Price > 5 & Price <= 10 ~ "5-10",
            Price > 10 & Price <= 15 ~ "10-15",
            Price > 15 & Price <= 20 ~ "15-20",
            Price > 20 & Price <= 25 ~ "20-25",
            Price > 25 & Price <= 30 ~ "25-30",
            Price > 30 & Price <= 35 ~ "30-35",
            Price > 35 & Price <= 40 ~ "35-40",
            Price > 40 ~ "40+"
        ))

    PriceDownloads <- df %>%
        group_by(Price_Range) %>%
        summarise(medDownloads = median(Installs),
                  avgDownloads = mean(Installs)) %>%
        arrange(desc(avgDownloads))
    colnames(PriceDownloads) <- c('Price Range','Median Downloads', 'Average Downloads')

    if (Latex) {
        finaltable <- options(xtable.comment = FALSE)
        finaltable <- xtable(PriceDownloads, caption = 'Price vs Downloads')
    } else{
        finaltable <- knitr::kable(PriceDownloads, caption = 'Price vs Downloads')
    }

    return(finaltable)
}
