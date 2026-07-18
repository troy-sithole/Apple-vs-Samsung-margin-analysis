CREATE VIEW v_segment_mix AS
SELECT 
    c.company_name,
    sr.fiscal_year,
    s.segment_name,
    sr.revenue_usd_millions,
    sr.gross_profit_usd_millions,
    sr.op_profit_usd_millions,
    ROUND(100.0 * sr.revenue_usd_millions / SUM(sr.revenue_usd_millions) OVER (PARTITION BY c.company_name, sr.fiscal_year), 1) AS pct_of_company_revenue
FROM segment_revenue sr
JOIN segments s ON sr.segment_id = s.segment_id
JOIN companies c ON s.company_id = c.company_id;