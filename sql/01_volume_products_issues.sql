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

--Which companies have the most untimely responses
SELECT company,
           COUNT(*) AS total_complaints,
           SUM(CASE WHEN timely_response = 'No' THEN 1 ELSE 0 END) AS untimely,
           ROUND(SUM(CASE WHEN timely_response = 'No' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS pct_untimely
    FROM complaints
    GROUP BY company
    HAVING COUNT(*) >= 100
    ORDER BY pct_untimely DESC
    LIMIT 10;

--Which companies have the most complaints still in progress
SELECT company,
           COUNT(*) AS total_complaints,
           SUM(CASE WHEN company_response_to_consumer = 'In progress' THEN 1 ELSE 0 END) AS in_progress
    FROM complaints
    GROUP BY company
    HAVING COUNT(*) >= 100
    ORDER BY in_progress DESC
    LIMIT 10;

--How do outcomes differ by product
SELECT product,
           COUNT(*) AS closed_complaints,
           ROUND(SUM(CASE WHEN company_response_to_consumer = 'Closed with monetary relief' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_monetary_relief,
           ROUND(SUM(CASE WHEN company_response_to_consumer = 'Closed with non-monetary relief' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_non_monetary,
           ROUND(SUM(CASE WHEN company_response_to_consumer = 'Closed with explanation' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_explanation
    FROM complaints
    WHERE company_response_to_consumer LIKE 'Closed%'
    GROUP BY product
    HAVING COUNT(*) >= 100
    ORDER BY closed_complaints DESC;

--Which Arkansas areas have the most complaints
SELECT zip3,
           COUNT(*) AS complaints,
           SUM(CASE WHEN is_credit_reporting THEN 0 ELSE 1 END) AS non_credit_reporting
    FROM complaints
    GROUP BY zip3
    ORDER BY complaints DESC
    LIMIT 10;

--Servicemember and Older American complaints
SELECT tags, COUNT(*) AS complaints,
           ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
    FROM complaints
    GROUP BY tags
    ORDER BY complaints DESC;