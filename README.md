# Replication of Dynan and Elmendorf (2024)

A replication and original quantitative extension of Karen Dynan and Douglas Elmendorf's 2024 Peterson Institute working paper, *"Fiscal Policy and the Pandemic-Era Surge in US Inflation: Lessons for the Future."*

## Overview

This project replicates five key figures from the paper using the authors' publicly available replication data, and extends their analysis with an original quantitative summary of forecast errors across GDP, unemployment, inflation, and the federal funds rate

The full report, including analysis and commentary, is in [`report/report.qmd`](report/report.qmd).

## Repository structure

```
dynan-replication/
├── data/raw/          # Original replication data from PIIE
├── scripts/           # Standalone R scripts for each figure
├── output/figures/    # Rendered figure images
├── report/            # Full Quarto report (source + rendered output)
```

## Reproducing this analysis

1. Clone this repository
2. Open `dynan-replication.Rproj` in RStudio
3. Install required packages: `tidyverse`, `readxl`, `patchwork`
4. Render `report/report.qmd`, or run individual scripts in `scripts/`

## Source

Dynan, Karen, and Douglas Elmendorf. 2024. "Fiscal Policy and the Pandemic-Era Surge in US Inflation: Lessons for the Future." Peterson Institute for International Economics Working Paper 24-22.

## Author

Cooper Beckmann, Harvard College