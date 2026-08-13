library(tidyverse)
library(readxl)

excel_sheets("data/raw/DE_fig_data_Excel_charts.xlsx")

fig9_raw <- read_excel("data/raw/DE_fig_data_Excel_charts.xlsx", sheet = "fig9_core_infl")
glimpse(fig9_raw)

fig9b <- read_excel(
  "data/raw/DE_fig_data_Excel_charts.xlsx",
  sheet = "fig9_core_infl",
  skip = 2,
  col_names = c("date", "t_diffusion_items", "t_diffusion_expenditures"),
  range = "E3:G71"
)

glimpse(fig9b)



# plot
ggplot(fig9b, aes(x = date)) +
  geom_rect(
    aes(xmin = as.Date("2020-03-01"), xmax = as.Date("2020-04-01"), ymin = -Inf, ymax = Inf),
    fill = "gray85"
  ) +

  geom_line(aes(y = t_diffusion_items, color = "t-diffusion: items"), linewidth = 0.8) +
  geom_line(aes(y = t_diffusion_expenditures, color = "t-diffusion: expenditures"), linewidth = 0.8) +
  scale_color_manual(values = c("t-diffusion: items" = "#1B4F72", "t-diffusion: expenditures" = "#C0392B")) +
  scale_y_continuous(breaks = seq(0, 60, by = 15)) +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  labs(
    title = "Measures of PCE Inflation Dispersion",
    subtitle = "Percent of items/expenditures with 12-month price increases 2+ standard deviations above their 5-year average",
    caption = "Shaded area corresponds to recession. Data Source: Federal Reserve Bank of San Francisco.",
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
