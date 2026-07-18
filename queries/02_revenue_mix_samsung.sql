-- Layer 1: Samsung revenue mix by segment (DX/DS/SDC/Harman), FY2021-2025
-- Shows % of total revenue per segment per year using a window function
-- Evidence for: cyclical mix driven by semiconductor pricing, no structural shift

SELECT 
    fiscal_year,
    s.segment_name,
    sr.revenue_usd_millions,
    ROUND(100.0 * sr.revenue_usd_millions / SUM(sr.revenue_usd_millions) OVER (PARTITION BY fiscal_year), 1) AS 
    pct_of_total
FROM segment_revenue sr
JOIN segments s ON sr.segment_id = s.segment_id
WHERE s.company_id = 2
ORDER BY fiscal_year, s.segment_name;