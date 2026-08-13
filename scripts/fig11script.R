p_lfpr <- ggplot(fig11, aes(x = date)) +
  geom_line(aes(y = jan2020, color = "1/2020"), linewidth = 0.9, linetype = "dashed") +
  geom_line(aes(y = feb2021, color = "2/2021"), linewidth = 0.9, linetype = "dashed") +
  geom_line(aes(y = jul2021, color = "7/2021"), linewidth = 0.9, linetype = "dashed") +
  geom_line(aes(y = actual, color = "Actual"), linewidth = 1.1, linetype = "solid") +
  scale_color_manual(values = c(
    "1/2020" = "#006994",
    "2/2021" = "#C0392B",
    "7/2021" = "#FFAE42",
    "Actual" = "gray70"
  )) +
  scale_x_date(date_breaks = "1 year", date_labels = "%m/%d/%y") +
  scale_y_continuous(limits = c(60, 64), breaks = seq(60, 64, by = 1)) +
  labs(
    title = "CBO Labor Force Participation Rate Projections",
    subtitle = "(percent)",
    caption = "Data Source: Congressional Budget Office and Bureau of Labor Statistics (via FRED).
Dashed segments start with quarter of projection publication. Solid lines correspond to available history at time of projection.",
    x = NULL,
    y = NULL,
    color = NULL
  ) +
  theme_minimal(base_size = 13) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(hjust = 0)
  )

ggsave("output/figures/fig11_lfpr_projections.png", plot = p_lfpr, width = 9, height = 5.5, dpi = 300)