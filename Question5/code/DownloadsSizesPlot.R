DownloadsSizesPlot <- function(appsDF){
    suppressMessages({
        suppressWarnings({
            df <- appsDF %>%
                filter(!Size =='Varies with device') %>%
                mutate(Size = ifelse(str_detect(Size, "k"),
                                     as.numeric(str_remove(Size, "k")) / 1024,
                                     as.numeric(str_remove(Size, "M")))) %>%
                mutate(Installs = str_remove(Installs, "\\+")) %>%
                mutate(Installs = as.numeric(gsub(',','',Installs))) %>%
                group_by(Category) %>%
                summarise(avgDownloads = mean(Installs),
                          avgSize = mean(Size)) %>%
                arrange(desc(avgDownloads)) %>%  #Only show Top 10 downloaded categories
                head(10) %>%
                mutate(Category = str_replace_all(Category, "_", " "),
                       Category = str_to_title(Category))

            g1 <- df %>%
                mutate(Category = fct_reorder(Category, avgDownloads)) %>%
                ggplot(aes(x=Category))+
                geom_bar(aes(y = avgDownloads, fill = 'Downloads'), stat = 'identity', color = 'black')+
                geom_point(aes(y = avgSize*200000, color = 'Megabytes'))+
                geom_line(aes(y= avgSize*200000, group = 1, color = 'Megabytes'))+

                scale_fill_manual(values = c('Downloads' = 'darkgreen'))+
                scale_color_manual(values = c('Megabytes' = 'navy'))+
                guides(color = guide_legend(title = NULL), fill = guide_legend(title = NULL))+
                theme_bw()+
                theme(legend.position = "bottom", axis.text.x = element_text(angle = 45, hjust = 1))+
                scale_y_continuous(
                    sec.axis = sec_axis(~./200000, name = "Average App Size (MB)")
                ) +
                labs(title = 'App Downloads and Sizes',
                     subtitle = "by Top 10 Categories",
                     y = 'Average Downloads',
                     caption = "Source: Google Play Store")

            return(g1)

        })
    })
}
