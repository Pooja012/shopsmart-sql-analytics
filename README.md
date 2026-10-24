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
