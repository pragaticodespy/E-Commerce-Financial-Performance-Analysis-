# E-Commerce-Financial-Performance-Analysis

A finance-grade Power BI dashboard for a clothing startup, built from raw transaction data plus pre-aggregated SQL outputs (channel efficiency, margin erosion, returns) and a 5-year forecast model.

> This repo contains the data, DAX, Power Query, theme, and layout spec needed to rebuild the dashboard from scratch in Power BI Desktop. 

## What's in here

| File | Purpose |
|---|---|
| `clothing_startup_data.csv` | Raw order-level transactions, 2021–2025 (6,150 orders). Revenue, COGS, margin, returns, discounts at the order level. |
| `acquisition_efficiency.csv` | Pre-aggregated channel performance (orders, AOV, gross profit, margin, return rate, net profit by acquisition channel). |
| `margin_erosion.csv` | Pre-aggregated, quarter x category x region x size view of gross profit wiped out by returns. |
| `returns.csv` | Pre-aggregated return rate by region x category x channel. |
| `financial_forecast_model.xlsx` | 5-year (FY2026-2030) 3-statement-style forecast with Upper/Base and Lower Case scenarios. |
| `powerbi_dax_complete.md` | The full build spec - Power Query M scripts, the DAX measure library, the date table, a theme JSON, page-by-page canvas layout, conditional formatting rules, and narrative insights for each page. |

## Dashboard structure

Six pages, built in this order:

1. **Executive Summary** - top-line KPIs, revenue/margin trend, category mix, return rate by channel
2. **Revenue & Growth** - revenue trend, YoY growth, order volume, AOV, regional mix
3. **Margin Analysis** - margin trend, category x region margin matrix, discount-vs-margin scatter, margin erosion detail
4. **Channel & Acquisition** - channel revenue/margin/return comparison, net profit after returns
5. **Returns Intelligence** - highest-risk region x category x channel combinations, return trend by quarter
6. **Scenario Forecast** - Upper/Base vs Lower Case revenue and margin forecast through FY2030

## Quick start

1. Open Power BI Desktop and import the four CSVs and the Excel forecast model using **Get Data**.
2. Add the `DateTable` DAX table (Section 4) and mark it as the official date table. Required before any year-over-year measure will calculate.
3. Build the table relationships listed in Section 2, Step 3.
4. Create a blank `_Measures` table and paste in the DAX measures (Section 3 - 9 groups).
5. Import the theme (Section 5): View -> Themes -> Browse for themes.
6. Build each page using the canvas layout and visual tables in Section 6.
7. Apply conditional formatting (Section 8) and sync slicers across pages.
8. Save as `dashboard.pbix`.

## Data notes

- Order-level dataset spans 2021-2025: 6 product categories, 5 acquisition channels, 4 regions.
- Blended average gross margin across the dataset is ~70%; blended return rate is ~15.6%.
- The forecast model's Upper/Base case figures are pulled directly from the Excel sheet. The Lower Case row values in the long-format `ForecastModel` table are recomputed from the model's own assumption inputs (lower AOV, higher per-order manufacturing cost, higher tax rate) - re-check these against the live model before treating them as final if the model changes.

## Why the pre-aggregated CSVs are kept as separate tables

`acquisition_efficiency.csv` and `margin_erosion.csv` are SQL output, not duplicates of the raw transaction data - they're pre-computed rollups Power BI can load and chart directly without recalculating aggregations across 6,150 rows on every visual render.
