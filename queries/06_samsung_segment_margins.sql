-- Segment-level operating margin trend by segment, Samsung, FY2021-2025
-- Finding: Semiconductors swung from +30.60% to -22.37% margin (2021-2023),
-- the single largest driver of Samsung's company-level margin collapse

WITH samsung_segment_margins AS (
    SELECT 
        sr.fiscal_year,
        s.segment_name,
        sr.revenue_usd_millions,
        sr.op_profit_usd_millions,
        ROUND(100.0 * sr.op_profit_usd_millions / sr.revenue_usd_millions, 2) AS segment_op_margin_pct
    FROM segment_revenue sr
    JOIN segments s ON sr.segment_id = s.segment_id
    WHERE s.company_id = 2
)
SELECT 
    fiscal_year,
    segment_name,
    revenue_usd_millions,
    segment_op_margin_pct,
    ROUND(segment_op_margin_pct - LAG(segment_op_margin_pct) OVER (PARTITION BY segment_name ORDER BY 
    fiscal_year), 2) AS margin_yoy_change
FROM samsung_segment_margins
ORDER BY segment_name, fiscal_year;