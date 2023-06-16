plotTempPrecip <- function(dat){

    monthlyDF <- dat %>%
        group_by(month) %>%
        summarise(maxTemp = mean(max_temp, na.rm = TRUE),
                  minTemp = mean(min_temp, na.rm = TRUE),
                  avgTemp = mean(mean_temp, na.rm = TRUE),
                  precip = mean(precipitation, na.rm = TRUE))


    g1 <- monthlyDF %>%
        ggplot(aes(x = month)) +
        geom_bar(aes(y = precip*6, fill = "Precipitation"), stat = "identity", alpha = 0.7) +
        scale_y_continuous(
            limits = c(0,26),
            sec.axis = sec_axis(~./6, name = "Precipitation (inches)")
        ) +
        geom_point(aes(y = avgTemp, color = "Average Temperature")) +
        geom_line(aes(y = avgTemp, group = 1, color = "Average Temperature")) +
        geom_point(aes(y = minTemp, color = "Minimum Temperature")) +
        geom_line(aes(y = minTemp, group = 1, color = "Minimum Temperature")) +
        geom_point(aes(y = maxTemp, color = "Maximum Temperature")) +
        geom_line(aes(y = maxTemp, group = 1, color = "Maximum Temperature")) +

        geom_text(aes(y = avgTemp, label = round(avgTemp,1)), vjust = -1) +
        geom_text(aes(y = minTemp, label = round(minTemp,1)), vjust = 1) +
        geom_text(aes(y = maxTemp, label = round(maxTemp,1)), vjust = -1) +

        scale_color_manual(values = c("Average Temperature" = "green", "Minimum Temperature" = "blue", "Maximum Temperature" = "red")) +
        scale_fill_manual(values = c("Precipitation" = "steelblue")) +
        guides(color = guide_legend(title = NULL), fill = guide_legend(title = NULL))+

        labs(x = "Month", y = "Temperature (Celcius)", subtitle = 'Daily averages by Month', caption = 'Source: UK National Weather Service') +
        ggtitle("Temperature & Precipation in London")+
        theme_bw()+
        theme(legend.position = "bottom")
    return(g1)

}

