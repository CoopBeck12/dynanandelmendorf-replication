library(tidyverse)
library(readxl)
library(ggplot2)
install.packages("patchwork")
library(patchwork)

excel_sheets("data/raw/DE_fig_data_Excel_charts.xlsx")

fig8 <- read_excel(
  "data/raw/DE_fig_data_Excel_charts.xlsx",
  sheet = "fig8_cbo_postARP_actual ",
  col_names = c(
    "date",
    "gdp_feb2021", "gdp_jul2021", "gdp_current",
    "ur_feb2021", "ur_jul2021", "ur_current",
    "infl_feb2021", "infl_jul2021", "infl_current",
    "fedfunds_feb2021", "fedfunds_jul2021", "fedfunds_current"
  ),
  range = "A4:M5"
)

glimpse(fig8)

fig8_gdp_long <- fig8 %>%
  select(date, gdp_feb2021, gdp_jul2021, gdp_current) %>%
  pivot_longer(
    cols = c(gdp_feb2021, gdp_jul2021, gdp_current),
    names_to = "vintage",
    values_to = "value"
  ) %>%
  mutate(
    year = year(date),
    vintage = recode(vintage,
                     "gdp_feb2021" = "February 2021",
                     "gdp_jul2021" = "July 2021",
                     "gdp_current" = "Current"
    )
  )

fig8_gdp_long

p_gdp <- ggplot(fig8_gdp_long, aes(x = factor(year), y = value, fill = vintage)) +
  geom_col(position = position_dodge(width = 0.75), width = 0.75, color = "gray30", linewidth = 0.3) +
  geom_text(
    aes(label = round(value, 1)),
    position = position_dodge(width = 0.75),
    vjust = -0.5,
    size = 3.5,
    color = "gray20"
  ) +
  scale_fill_manual(values = c(
    "February 2021" = "#AED6F1",
    "July 2021" = "#1B4F72",
    "Current" = "#F5B041"
  )) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Q4/Q4 Real GDP Growth",
    subtitle = "Percent",
    x = NULL,
    y = NULL,
    fill = NULL
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(color = "gray40"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_text(color = "gray30")
  )

fig8_ur_long <- fig8 %>%
  select(date, ur_feb2021, ur_jul2021, ur_current) %>%
  pivot_longer(
    cols = c(ur_feb2021, ur_jul2021, ur_current),
    names_to = "vintage",
    values_to = "value"
  ) %>%
 
  mutate(
    year = year(date),
    vintage = recode(vintage,
                     "ur_feb2021" = "February 2021",
                     "ur_jul2021" = "July 2021",
                     "ur_current" = "Current"
    ),
    vintage = factor(vintage, levels = c("February 2021", "July 2021", "Current"))
  )

fig8_ur_long

p_ur <- ggplot(fig8_ur_long, aes(x = factor(year), y = value, fill = vintage)) +
  geom_col(position = position_dodge(width = 0.75), width = 0.75, color = "gray30", linewidth = 0.3) +
  geom_text(
    aes(label = round(value, 1)),
    position = position_dodge(width = 0.75),
    vjust = -0.5,
    size = 3.5,
    color = "gray20"
  ) +
  scale_fill_manual(values = c(
    "February 2021" = "#AED6F1",
    "July 2021" = "#1B4F72",
    "Current" = "#F5B041"
  )) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Q4 Unemployment Rate",
    subtitle = "Percent",
    x = NULL,
    y = NULL,
    fill = NULL
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(color = "gray40"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_text(color = "gray30")
  )

fig8_infl_long <- fig8 %>%
  select(date, infl_feb2021, infl_jul2021, infl_current) %>%
  pivot_longer(
    cols = c(infl_feb2021, infl_jul2021, infl_current),
    names_to = "vintage",
    values_to = "value"
  ) %>%
  
  mutate(
    year = year(date),
    vintage = recode(vintage,
                     "infl_feb2021" = "February 2021",
                     "infl_jul2021" = "July 2021",
                     "infl_current" = "Current"
    ),
    vintage = factor(vintage, levels = c("February 2021", "July 2021", "Current"))
  )

fig8_infl_long

p_infl <- ggplot(fig8_infl_long, aes(x = factor(year), y = value, fill = vintage)) +
  geom_col(position = position_dodge(width = 0.75), width = 0.75, color = "gray30", linewidth = 0.3) +
  geom_text(
    aes(label = round(value, 1)),
    position = position_dodge(width = 0.75),
    vjust = -0.5,
    size = 3.5,
    color = "gray20"
  ) +
  scale_fill_manual(values = c(
    "February 2021" = "#AED6F1",
    "July 2021" = "#1B4F72",
    "Current" = "#F5B041"
  )) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Q4/Q4 Core PCE Inflation",
    subtitle = "Percent",
    x = NULL,
    y = NULL,
    fill = NULL
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(color = "gray40"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_text(color = "gray30")
  )

fig8_fedfunds_long <- fig8 %>%
  select(date, fedfunds_feb2021, fedfunds_jul2021, fedfunds_current) %>%
  pivot_longer(
    cols = c(fedfunds_feb2021, fedfunds_jul2021, fedfunds_current),
    names_to = "vintage",
    values_to = "value"
  ) %>%
  
  mutate(
    year = year(date),
    vintage = recode(vintage,
                     "fedfunds_feb2021" = "February 2021",
                     "fedfunds_jul2021" = "July 2021",
                     "fedfunds_current" = "Current"
    ),
    vintage = factor(vintage, levels = c("February 2021", "July 2021", "Current"))
  )

fig8_fedfunds_long

p_fedfunds <- ggplot(fig8_fedfunds_long, aes(x = factor(year), y = value, fill = vintage)) +
  geom_col(position = position_dodge(width = 0.75), width = 0.75, color = "gray30", linewidth = 0.3) +
  geom_text(
    aes(label = round(value, 1)),
    position = position_dodge(width = 0.75),
    vjust = -0.5,
    size = 3.5,
    color = "gray20"
  ) +
  scale_fill_manual(values = c(
    "February 2021" = "#AED6F1",
    "July 2021" = "#1B4F72",
    "Current" = "#F5B041"
  )) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Q4 Federal Funds Rate",
    subtitle = "Percent",
    x = NULL,
    y = NULL,
    fill = NULL
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(color = "gray40"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_text(color = "gray30")
  )

combined_fig8 <- (p_gdp | p_ur) / (p_infl | p_fedfunds) +
  plot_annotation(
    title = "CBO Projections and Actual Realizations",
    theme = theme(plot.title = element_text(face = "bold", size = 17))
  )

ggsave("output/figures/fig8_cbo_projections.png", plot = combined_fig8, width = 11, height = 9, dpi = 300)


