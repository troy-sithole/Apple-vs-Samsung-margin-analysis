CREATE VIEW v_company_margins AS
SELECT 
    c.company_name,
    cf.fiscal_year,
    cf.revenue_usd_millions,
    cf.gross_profit_usd_millions,
    cf.op_profit_usd_millions,
    cf.net_profit_usd_millions,
    ROUND(100.0 * cf.gross_profit_usd_millions / cf.revenue_usd_millions, 2) AS gross_margin_pct,
    ROUND(100.0 * cf.op_profit_usd_millions / cf.revenue_usd_millions, 2) AS operating_margin_pct,
    ROUND(100.0 * cf.net_profit_usd_millions / cf.revenue_usd_millions, 2) AS net_margin_pct
FROM company_financials cf
JOIN companies c ON cf.company_id = c.company_id;