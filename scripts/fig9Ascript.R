library(tidyverse)
library(readxl)

excel_sheets("data/raw/DE_fig_data_Excel_charts.xlsx")

fig9_raw <- read_excel("data/raw/DE_fig_data_Excel_charts.xlsx", sheet = "fig9_core_infl")
glimpse(fig9_raw)

fig9a <- read_excel(
  "data/raw/DE_fig_data_Excel_charts.xlsx",
  sheet = "fig9_core_infl",
  skip = 2,
  col_names = c("date", "core_pce", "trimmed_mean", "recession"),
  range = "A3:D72"
)

# remove blanks
fig9a <- fig9a %>%
  filter(!is.na(date))

glimpse(fig9a)

# recession shading data
recession_periods <- fig9a %>%
  filter(recession == 1) %>%
  summarise(start = min(date), end = max(date))

recession_periods

# plot
ggplot(fig9a, aes(x = date)) +
  geom_rect(
    data = recession_periods,
    aes(xmin = start, xmax = end, ymin = -Inf, ymax = Inf),
    inherit.aes = FALSE,
    fill = "gray85"
  ) +
  geom_line(aes(y = core_pce, color = "Core PCE"), linewidth = 0.8) +
  geom_line(aes(y = trimmed_mean, color = "Trimmed Mean"), linewidth = 0.8) +
  scale_color_manual(values = c("Core PCE" = "#1B4F72", "Trimmed Mean" = "#C0392B")) +
  scale_y_continuous(breaks = seq(0, 6, by = 1)) +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
    labs(
    title = "PCE Inflation Measures, 2019–2024",
    subtitle = "Six-month annualized percent change",
    caption = "Shaded area corresponds to recession. Data Source: Bureau of Economic Analysis; Dallas Fed (via FRED)",
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

ggsave("output/figures/fig9a_core_inflation.png", width = 8, height = 5, dpi = 300)
