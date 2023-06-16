demographyPlot <- function(df, nocol, norow){
    suppressMessages({
        suppressWarnings({
            featureDF <- df %>%
                filter(!continent == '') %>%
                mutate(date = as.Date(date)) %>%
                filter(date==max(date)) %>%
                select(location, continent, extreme_poverty, male_smokers, female_smokers,
                       life_expectancy, aged_65_older, human_development_index,
                       total_cases, total_deaths) %>%
                mutate(totSmokers = male_smokers + female_smokers)

            scatter <- function(df, xvariable, title, xlab){
                g1 <- df %>%
                    filter(total_deaths<250000) %>%
                    ggplot(aes(x= .data[[xvariable]], y=total_deaths, color = continent, shape=continent))+
                    geom_point(size = 3)+
                    geom_smooth(method = 'lm', aes(group=1))+
                    labs(x=xlab,
                         y='Total Deaths',
                         title = title,
                         caption = 'Source: OWID (Our World in Data)')+
                    guides(color = guide_legend(title = "Continent"), shape = guide_legend(title = 'Continent'))+
                    theme_bw()
                return(g1)
            }

            p1 <- scatter(featureDF, 'aged_65_older', 'Elderly Population vs Covid Deaths', '% of population older than 65')
            p2 <- scatter(featureDF, 'totSmokers', 'Smokers vs Covid Deaths', '% of population that smokes')
            p3 <- scatter(featureDF, 'life_expectancy', 'Life Expectancy vs Covid Deaths', 'Life Expectancy')
            p4 <- scatter(featureDF, 'human_development_index', 'HDI vs Covid Deaths', 'Human Development Index')
            arranged <- ggarrange(p1,p2,p3,p4, ncol = nocol, nrow = norow)
            return(arranged)
        })
    })

}

demographyPlot(CovidDF, 2, 2)
