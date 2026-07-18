-- Layer 2: Year-over-year margin change using LAG(), Apple vs Samsung
-- Quantifies volatility: Apple's largest YoY swing vs Samsung's largest YoY swing

SELECT 
    company_name,
    fiscal_year,
    gross_margin_pct,
    ROUND(gross_margin_pct - LAG(gross_margin_pct) OVER (PARTITION BY company_name ORDER BY fiscal_year), 2) AS 
    gross_margin_yoy_change,
    operating_margin_pct,
    ROUND(operating_margin_pct - LAG(operating_margin_pct) OVER (PARTITION BY company_name ORDER BY fiscal_year), 
    2) AS operating_margin_yoy_change
FROM (
    SELECT 
        c.company_name,
        cf.fiscal_year,
        ROUND(100.0 * cf.gross_profit_usd_millions / cf.revenue_usd_millions, 2) AS gross_margin_pct,
        ROUND(100.0 * cf.op_profit_usd_millions / cf.revenue_usd_millions, 2) AS operating_margin_pct
    FROM company_financials cf
    JOIN companies c ON cf.company_id = c.company_id
) sub
ORDER BY company_name, fiscal_year;