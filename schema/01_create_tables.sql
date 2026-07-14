CREATE TABLE companies (
    company_id          SERIAL PRIMARY KEY,
    company_name        VARCHAR(50),
    reporting_currency  VARCHAR(10),
    fiscal_year_end     VARCHAR(20)
);

CREATE TABLE segments (
    segment_id      SERIAL PRIMARY KEY,
    company_id      INT REFERENCES companies(company_id),
    segment_label   VARCHAR(50),
    segment_name    VARCHAR(50)
);

CREATE TABLE segment_revenue (
    id                      SERIAL PRIMARY KEY,
    segment_id              INT REFERENCES segments(segment_id),
    fiscal_year             INT,
    revenue_usd_millions    NUMERIC(12,2),
    op_profit_usd_millions  NUMERIC(12,2),
    gross_profit_usd_millions NUMERIC(12,2)
);

CREATE TABLE company_financials (
    id                          SERIAL PRIMARY KEY,
    company_id                  INT REFERENCES companies(company_id),
    fiscal_year                 INT,
    revenue_usd_millions        NUMERIC(12,2),
    cost_of_sales_usd_millions  NUMERIC(12,2),
    gross_profit_usd_millions   NUMERIC(12,2),
    op_profit_usd_millions      NUMERIC(12,2),
    net_profit_usd_millions     NUMERIC(12,2)
);