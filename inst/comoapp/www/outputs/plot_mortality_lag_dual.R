output$plot_mortality_lag_baseline <- renderPlot({
  req(simul_baseline$baseline_available)
  req(simul_interventions$interventions_available)
  req(simul_baseline$results$med$mortality_lag %>% ncol() > 1)
  req(simul_interventions$results$med$mortality_lag %>% ncol() > 1)
  
  age_reorder <- as.character(simul_baseline$results$med$mortality_lag$Age)
  
  dta_baseline <- simul_baseline$results$med$mortality_lag %>%
    rename(`Day 30` = day30, `Day 60` = day60, `Day 90` = day90, `Day 120` = day120) %>%
    pivot_longer(-Age, names_to = "Lag", values_to = "Mortality") %>% 
    mutate(Age = fct_relevel(Age, age_reorder),
           Lag = factor(Lag, levels = c("Day 30", "Day 60", "Day 90", "Day 120")))
  
  dta_interventions <- simul_interventions$results$med$mortality_lag %>%
    rename(`Day 30` = day30, `Day 60` = day60, `Day 90` = day90, `Day 120` = day120) %>%
    pivot_longer(-Age, names_to = "Lag", values_to = "Mortality") %>% 
    mutate(Age = fct_relevel(Age, age_reorder),
           Lag = factor(Lag, levels = c("Day 30", "Day 60", "Day 90", "Day 120")))
  
  max_y = max(dta_baseline$Mortality, dta_interventions$Mortality)
  
  ggplot(dta_baseline, aes(x = Age, y = Mortality, color = Lag)) +
    geom_point(size = 3) +
    scale_y_continuous(limits = c(0, max_y)) +
    scale_color_manual(values = c("Day 30" = "#ca0020", "Day 60" = "#f4a582", "Day 90" = "#92c5de", "Day 120" = "#0571b0")) +
    theme_minimal(base_size = 14) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1.2),
          legend.position = "bottom", legend.text = element_text(size = 13)) +
    labs(title = "Case Fatality Ratio by Age", subtitle = "Baseline",
         x = "", y = "Fatality Rate", color = "Measured at:")
})

output$plot_mortality_lag_interventions <- renderPlot({
  req(simul_baseline$baseline_available)
  req(simul_interventions$interventions_available)
  
  age_reorder <- as.character(simul_baseline$results$med$mortality_lag$Age)
  
  dta_baseline <- simul_baseline$results$med$mortality_lag %>%
    rename(`Day 30` = day30, `Day 60` = day60, `Day 90` = day90, `Day 120` = day120) %>%
    pivot_longer(-Age, names_to = "Lag", values_to = "Mortality") %>% 
    mutate(Age = fct_relevel(Age, age_reorder),
           Lag = factor(Lag, levels = c("Day 30", "Day 60", "Day 90", "Day 120")))
  
  dta_interventions <- simul_interventions$results$med$mortality_lag %>%
    rename(`Day 30` = day30, `Day 60` = day60, `Day 90` = day90, `Day 120` = day120) %>%
    pivot_longer(-Age, names_to = "Lag", values_to = "Mortality") %>% 
    mutate(Age = fct_relevel(Age, age_reorder),
           Lag = factor(Lag, levels = c("Day 30", "Day 60", "Day 90", "Day 120")))
  
  max_y = max(dta_baseline$Mortality, dta_interventions$Mortality)
  
  ggplot(dta_interventions, aes(x = Age, y = Mortality, color = Lag)) +
    geom_point(size = 3) +
    scale_y_continuous(limits = c(0, max_y)) +
    scale_color_manual(values = c("Day 30" = "#ca0020", "Day 60" = "#f4a582", "Day 90" = "#92c5de", "Day 120" = "#0571b0")) +
    theme_minimal(base_size = 14) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1.2),
          legend.position = "bottom", legend.text = element_text(size = 13)) +
    labs(title = "Case Fatality Ratio by Age", subtitle = "Hypothetical Scenario",
         x = "", y = "Fatality Rate", color = "Measured at:")
})