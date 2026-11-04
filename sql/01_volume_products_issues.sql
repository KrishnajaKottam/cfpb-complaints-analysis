--Are complaints going up or down?
WITH monthly AS (
        SELECT month, COUNT(*) AS complaints
        FROM complaints
        WHERE month BETWEEN '2024-01' AND '2026-10'
        GROUP BY month
    )
    SELECT month,
           complaints,
           LAG(complaints) OVER (ORDER BY month) AS previous_month,
           ROUND((complaints - LAG(complaints) OVER (ORDER BY month)) * 100.0
                 / LAG(complaints) OVER (ORDER BY month), 1) AS pct_change
    FROM monthly
    ORDER BY month;

--Who drives credit reporting complaints
SELECT company,
           COUNT(*) AS complaints,
           ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct_of_credit_reporting
    FROM complaints
    WHERE is_credit_reporting
    GROUP BY company
    ORDER BY complaints DESC
    LIMIT 5;

--What are the top problems in credit reporting?
SELECT issue, COUNT(*) AS complaints,
           ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
    FROM complaints
    WHERE is_credit_reporting
    GROUP BY issue
    ORDER BY complaints DESC
    LIMIT 5;

--Outside credit reporting, which products have the most complaints
SELECT product, COUNT(*) AS complaints,
           ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct_of_non_credit
    FROM complaints
    WHERE NOT is_credit_reporting
    GROUP BY product
    ORDER BY complaints DESC;

--Top 3 issues for each of those products
WITH counts AS (
        SELECT product, issue, COUNT(*) AS complaints
        FROM complaints
        WHERE NOT is_credit_reporting
        GROUP BY product, issue
    ),
    ranked AS (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY product ORDER BY complaints DESC) AS rank_in_product
        FROM counts
    )
    SELECT product, rank_in_product, issue, complaints
    FROM ranked
    WHERE rank_in_product <= 3
    ORDER BY product, rank_in_product;