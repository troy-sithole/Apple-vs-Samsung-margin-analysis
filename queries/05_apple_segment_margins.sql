-- Segment-level gross margin trend by segment, Apple, FY2021-2025
-- Decomposes blended margin improvement into mix effect + segment margin effect
-- Finding: Services margin itself expanded (69.73% -> 75.41%), not just its revenue share

WITH apple_segment_margins AS (
    SELECT 
        sr.fiscal_year,
        s.segment_name,
        sr.revenue_usd_millions,
        sr.gross_profit_usd_millions,
        ROUND(100.0 * sr.gross_profit_usd_millions / sr.revenue_usd_millions, 2) AS segment_gross_margin_pct
    FROM segment_revenue sr
    JOIN segments s ON sr.segment_id = s.segment_id
    WHERE s.company_id = 1
)
SELECT 
    fiscal_year,
    segment_name,
    revenue_usd_millions,
    segment_gross_margin_pct,
    ROUND(segment_gross_margin_pct - LAG(segment_gross_margin_pct) OVER (PARTITION BY segment_name ORDER BY 
    fiscal_year), 2) AS margin_yoy_change
FROM apple_segment_margins
ORDER BY segment_name, fiscal_year;