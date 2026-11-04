-- Complaints per year (2023 and 2026 are partial years)
SELECT year, COUNT(*) AS complaints
FROM complaints
GROUP BY year
ORDER BY year;

--Top 10 companies with complaints
SELECT company, COUNT(*) AS complaints
    FROM complaints
    GROUP BY company
    ORDER BY complaints DESC
    LIMIT 10;

--what share of complaints is each product?
SELECT product,
           COUNT(*) AS complaints,
           ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct_of_total
    FROM complaints
    GROUP BY product
    ORDER BY complaints DESC;

--How are companies respoinding?
SELECT company_response_to_consumer AS response,
           COUNT(*) AS complaints
    FROM complaints
    GROUP BY response
    ORDER BY complaints DESC;

--How many complaints are credit reporting vs everything
SELECT is_credit_reporting,
           COUNT(*) AS complaints,
           ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct_of_total
    FROM complaints
    GROUP BY is_credit_reporting;
