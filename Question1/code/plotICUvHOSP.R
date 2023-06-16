plotICUvHOSP <- function(dat){
    suppressMessages({
        suppressWarnings({
            continentHospitalDF <- dat %>%
                filter(!is.na(hosp_patients)) %>%
                filter(!is.na(icu_patients)) %>%
                filter(!continent == '') %>%
                group_by(continent, date) %>%
                summarise(totHospitalPatients = sum(hosp_patients_per_million), totICU = sum(icu_patients_per_million)) %>%
                mutate(date = as.Date(date))


            g1 <- ggplot(continentHospitalDF, aes(x = date)) +
                geom_line(aes(y = totHospitalPatients, color = "Hospitalizations"), size = 1) +
                geom_line(aes(y = totICU, color = "ICU Admissions"), size = 1) +
                scale_color_manual(values = c("Hospitalizations" = "blue", "ICU Admissions" = "red")) +
                scale_y_continuous(sec.axis = sec_axis(~., name = "ICU Admissions")) +
                labs(title = "Hospitalizations vs. ICU Admissions",
                     x = "Date",
                     y = "Hospitalizations") +
                guides(color = guide_legend(title = "")) +
                theme_bw() +
                theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "bottom")+
                facet_wrap(~ continent, scales = "free_y", ncol = 2)
            return(g1)
        })
    }
    )}



