show tables;
select * from student_info;
select * from student_engagement;
select * from student_purchases;

-- This query retrieves each student's registration date, their first video watched date,
-- and their first course purchase date (if any). It calculates:
-- 1. The number of days between registration and first watched video
-- 2. The number of days between first watched video and first purchase
-- Only includes students who either never purchased, or purchased on/after their first watch.
SELECT 
    a.student_id, 
    a.date_registered, 
    MIN(b.date_watched) AS first_date_watched,
    MIN(c.date_purchased) AS first_date_purchased,
    DATEDIFF(MIN(b.date_watched), a.date_registered) AS days_diff_reg_watch,
    DATEDIFF(MIN(c.date_purchased), MIN(b.date_watched)) AS days_diff_watch_purch
FROM 
    student_info a
JOIN 
    student_engagement b ON a.student_id = b.student_id
LEFT JOIN 
    student_purchases c ON a.student_id = c.student_id
GROUP BY 
    a.student_id, a.date_registered
HAVING 
    first_date_purchased IS NULL 
    OR first_date_watched <= first_date_purchased;


-- Analyze student behavior to understand conversion from free to paid:
-- Step 1: Create a CTE (student_behavior) to collect for each student:
--   - Registration date
--   - First video watched date
--   - First course purchase date (if any)
--   - Days from registration to first watch
--   - Days from first watch to purchase (if applicable)
--   - Filter: Keep students who never purchased or purchased after watching
WITH student_behavior AS (
    SELECT 
        a.student_id, 
        a.date_registered, 
        MIN(b.date_watched) AS first_date_watched,
        MIN(c.date_purchased) AS first_date_purchased,
        DATEDIFF(MIN(b.date_watched), a.date_registered) AS days_diff_reg_watch,
        DATEDIFF(MIN(c.date_purchased), MIN(b.date_watched)) AS days_diff_watch_purch
    FROM 
        student_info a
    JOIN 
        student_engagement b ON a.student_id = b.student_id
    LEFT JOIN 
        student_purchases c ON a.student_id = c.student_id
    GROUP BY 
        a.student_id, a.date_registered
    HAVING 
        first_date_purchased IS NULL 
        OR first_date_watched <= first_date_purchased
)
-- Step 2: Calculate key metrics:
--   - Conversion Rate: % of students who watched and then purchased
--   - Avg. days from registration to first watch
--   - Avg. days from first watch to purchase (only for converted users)

SELECT 
    ROUND(
        COUNT(CASE 
            WHEN first_date_purchased IS NOT NULL 
                 AND first_date_purchased >= first_date_watched 
            THEN student_id 
        END) * 100.0 
        / COUNT(first_date_watched), 2
    ) AS conversion_rate,

    ROUND(
        SUM(days_diff_reg_watch) * 1.0 
        / COUNT(first_date_watched), 2
    ) AS av_reg_watch,

    ROUND(
        SUM(CASE 
            WHEN first_date_purchased IS NOT NULL 
                 AND first_date_purchased >= first_date_watched 
            THEN days_diff_watch_purch 
        END) * 1.0 
        / COUNT(CASE 
            WHEN first_date_purchased IS NOT NULL 
                 AND first_date_purchased >= first_date_watched 
            THEN student_id 
        END), 2
    ) AS av_watch_purch
FROM 
    student_behavior;