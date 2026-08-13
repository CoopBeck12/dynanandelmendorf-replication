forecast_errors <- fig8 %>%
  mutate(year = year(date)) %>%
  transmute(
    year,
    gdp_error_feb = gdp_current - gdp_feb2021,
    gdp_error_jul = gdp_current - gdp_jul2021,
    ur_error_feb = ur_current - ur_feb2021,
    ur_error_jul = ur_current - ur_jul2021,
    infl_error_feb = infl_current - infl_feb2021,
    infl_error_jul = infl_current - infl_jul2021,
    fedfunds_error_feb = fedfunds_current - fedfunds_feb2021,
    fedfunds_error_jul = fedfunds_current - fedfunds_jul2021
  )

forecast_errors

print(forecast_errors, width = Inf)

error_summary <- forecast_errors %>%
  summarise(
    GDP = mean(abs(c(gdp_error_feb, gdp_error_jul))),
    Unemployment = mean(abs(c(ur_error_feb, ur_error_jul))),
    Inflation = mean(abs(c(infl_error_feb, infl_error_jul))),
    `Fed Funds Rate` = mean(abs(c(fedfunds_error_feb, fedfunds_error_jul)))
  ) %>%
  pivot_longer(everything(), names_to = "Variable", values_to = "Mean Absolute Forecast Error") %>%
  arrange(desc(`Mean Absolute Forecast Error`))

error_summary

write_csv(error_summary, "output/error_summary.csv")

p_error_summary <- ggplot(error_summary, aes(x = reorder(Variable, `Mean Absolute Forecast Error`), 
                                             y = `Mean Absolute Forecast Error`)) +
  geom_col(fill = "#1B4F72", color = "gray30", linewidth = 0.3, width = 0.6)

p_error_summary

p_error_summary <- ggplot(error_summary, aes(x = reorder(Variable, `Mean Absolute Forecast Error`), 
                                             y = `Mean Absolute Forecast Error`)) +
  geom_col(fill = "#1B4F72", color = "gray30", linewidth = 0.3, width = 0.6) +
  geom_text(aes(label = round(`Mean Absolute Forecast Error`, 2)), 
            hjust = +0.5, nudge_y = 0.1, size = 3.8, color = "gray20") +
  labs(
    x = NULL,
    y = "Mean Absolute Error (percent)"
  )

p_error_summary

ggsave("output/figures/original_forecast_error_summary.png", plot = p_error_summary, width = 8, height = 5, dpi = 300)