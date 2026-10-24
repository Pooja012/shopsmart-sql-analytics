# ShopSmart SQL Analytics

SQLite project analysing a synthetic e-commerce dataset (120 customers, 40 products, 500 orders, 1,200 order items).

## Run it
    ./build.sh

## Files (run in this order)
| File | Purpose |
|---|---|
| 01_schema.sql | Table definitions |
| 02_seed_data.sql | Generates the synthetic data |
| 03_exploration.sql | Row counts, date ranges, integrity checks |
| 04_revenue_trends.sql | Monthly revenue and month-over-month change |
| 05_product_insights.sql | Category and top-product revenue, unsold products |
| 06_customer_rfm.sql | RFM customer segmentation |
| 07_views_indexes.sql | Reporting views and indexes |

Revenue figures exclude cancelled orders.

## Findings (synthetic data)

- **Revenue:** about 17k to 25.5k per month across Feb 2025 to Sep 2026, with no clear trend. March 2025 was the peak (25,541). September 2026 is a partial month.
- **Categories:** Grocery leads revenue (167,988), followed by Clothing (106,553), Electronics (93,594) and Home (35,518).
- **Products:** Grocery Item 22 is the top product (33,119, about 8.2% of revenue). Five of the top ten are Grocery.
- **Data quality:** all integrity checks pass, and every product has at least one completed sale.
- **Customers:** RFM segmentation scores each customer 1 to 5 on recency, frequency and monetary value. Customer 44 is the top Champion (555).
- **Caveat:** the dataset is generated, so patterns such as Grocery's lead come from the seed formulas, not from real behaviour.
