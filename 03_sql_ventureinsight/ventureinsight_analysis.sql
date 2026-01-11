/*
VentureInsight SQL Case Study
Analyst: Chinnisa Elvy
Program: TripleTen Business Intelligence Analyst Program

This SQL analysis explores startup outcomes, funding behavior,
acquisition trends, and venture fund investment strategies using
a relational venture capital database.
*/

-- 1. Startup Failure Baseline
-- Count the number of companies that have closed
SELECT COUNT(*) AS closed_company_count
FROM company
WHERE status = 'closed';


-- 2. U.S. News & Media Funding Analysis
-- Identify how much funding U.S.-based news companies have raised
SELECT
    name,
    funding_total
FROM company
WHERE category_code = 'news'
  AND country_code = 'USA'
ORDER BY funding_total DESC;


-- 3. Cash Acquisition Trends (2011–2013)
-- Calculate total value of cash-based acquisitions during post-recession years
SELECT
    SUM(price_amount) AS total_cash_acquisitions_usd
FROM acquisition
WHERE term_code = 'cash'
  AND acquired_at >= DATE '2011-01-01'
  AND acquired_at <  DATE '2014-01-01';


-- 4. Funding Round Volatility Analysis
-- Identify dates with significant variation between smallest and largest funding rounds
SELECT
    funded_at,
    MAX(raised_amount) AS max_raised,
    MIN(raised_amount) AS min_raised
FROM funding_round
GROUP BY funded_at
HAVING MIN(raised_amount) > 0
   AND MIN(raised_amount) <> MAX(raised_amount);


-- 5. Venture Fund Activity Classification
-- Categorize funds based on number of companies invested in
SELECT
    *,
    CASE
        WHEN invested_companies >= 100 THEN 'high_activity'
        WHEN invested_companies >= 20 THEN 'middle_activity'
        ELSE 'low_activity'
    END AS activity_level
FROM fund;


-- 6. Average Funding Rounds by Fund Activity Level
-- Compare investment behavior across fund activity tiers
SELECT
    CASE
        WHEN invested_companies >= 100 THEN 'high_activity'
        WHEN invested_companies >= 20 THEN 'middle_activity'
        ELSE 'low_activity'
    END AS activity_level,
    ROUND(AVG(investment_rounds)) AS avg_funding_rounds
FROM fund
GROUP BY activity_level
ORDER BY avg_funding_rounds;


-- 7. Education Levels at Failed Startups
-- Analyze average number of degrees per employee at startups that failed after one funding round
SELECT AVG(t.degree_count) AS avg_degrees_per_employee
FROM (
    SELECT
        p.id,
        COUNT(e.degree_type) AS degree_count
    FROM people p
    JOIN education e
      ON p.id = e.person_id
    WHERE p.company_id IN (
        SELECT id
        FROM company
        WHERE status = 'closed'
          AND id IN (
              SELECT company_id
              FROM funding_round
              WHERE is_first_round = 1
                AND is_last_round = 1
          )
    )
    GROUP BY p.id
) t;
