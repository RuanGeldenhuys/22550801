plotCovidLollipop <- function(covidData){
    sumDeaths <- CovidDF %>%
        filter(!continent == '') %>%
        filter(!is.na(total_deaths)) %>%
        group_by(continent) %>%
        summarise(totDeaths = sum(new_deaths, na.rm = TRUE), totPopulation = sum(population, na.rm = TRUE))


    g1 <- sumDeaths %>%
        mutate(continent = fct_reorder(continent, totDeaths)) %>%
        ggplot(aes(x=continent, y=totDeaths))+
        geom_segment(aes(x=continent, xend=continent, y=0, yend=totDeaths)) +
        geom_point( aes(size = totPopulation), color="navy", fill=alpha("blue", 0.3), alpha=0.7, shape=21, stroke=2) +
        scale_size(range = c(3,15))+
        theme_bw()+
        theme(legend.position = 'none')+
        labs(x='Continent', y='Total Covid Deaths', caption = "Source: OWID (Our World in Data)")+
        ggtitle("Covid Deaths by Continent") +
        scale_x_discrete(guide = guide_axis(n.dodge = 2))

    return(g1)

}





plotCovidArea <- function(covidData){
    suppressMessages({
        continent_avg <- CovidDF%>%
        filter(!is.na(total_deaths)) %>%
        filter(!continent == '') %>%
        group_by(continent, date) %>%
        summarise(TotDeaths = sum(total_deaths)) %>%
        mutate(date = as.Date(date))
    })

    g2 <- continent_avg %>%
        ggplot(aes(x=date, y=TotDeaths, fill=reorder(continent, TotDeaths)))+
        geom_area()+
        scale_fill_viridis(discrete = TRUE)+
        labs(title = 'Covid deaths by Continent over time', x="Date", y="Total Deaths",
             caption = "Source: OWID (Our World in Data)", fill='Continent')+
        theme_bw()
    return(g2)
}


