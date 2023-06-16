coveragePlot <- function(dat, title){
    suppressMessages({
        suppressWarnings({
            coverageDF <- dat %>%
                filter(!is.na(cloud_cover)) %>%
                mutate(sunny = ifelse(cloud_cover<=2,1,0)) %>% #Under 20% cloud coverage = sunny
                mutate(partly = ifelse(cloud_cover<7 & cloud_cover > 2,1,0)) %>% #between 20 and 70 = partly cloudy
                mutate(overcast = ifelse(cloud_cover >= 7, 1, 0)) %>%  #over 70 = overcast
                select(c(11:14))

            df_long <- coverageDF %>%
                pivot_longer(cols = c(sunny, partly, overcast),
                             names_to = "weather",
                             values_to = "value") %>%
                group_by(month, weather) %>%
                summarise(average = mean(value, na.rm = TRUE)*30) %>%
                ungroup()

            ggplot(df_long, aes(x = month, y = average, fill = weather)) +
                geom_bar(stat = "identity") +
                labs(x = "Month", y = "Total days", fill = "Weather type") +
                ggtitle(title)+
                theme_bw()+
                theme(legend.position = "bottom")+
                labs(caption = 'Source: UK National Weather Service') +
                scale_fill_viridis(discrete = TRUE, labels=c('Overcast', 'Partly Cloudy','Sunny'))
        })

    })


}

