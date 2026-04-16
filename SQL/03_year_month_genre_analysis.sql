-- =========================================
-- 📊 Movie Analysis: Year, Month & Genre Trends
-- Dataset: Movies (2010–2025)
-- Purpose: Understand time + genre performance
-- =========================================


-- =========================
-- 📅 1. Year-wise Performance Analysis
-- =========================

SELECT 
    release_year,
    COUNT(*) AS total_movies,
    ROUND(SUM(profit), 0) AS total_profit,
    ROUND(AVG(profit), 0) AS avg_profit,
    SUM(CASE WHEN is_hit = 'Hit' THEN 1 ELSE 0 END) AS total_hits,
    SUM(CASE WHEN is_hit = 'Flop' THEN 1 ELSE 0 END) AS total_flops
FROM movie
WHERE budget > 0 AND revenue > 0
GROUP BY release_year
ORDER BY release_year;


-- =========================
-- 📆 2. Month-wise Performance Analysis
-- =========================

SELECT 
    MONTH(date_added) AS release_month,
    MONTHNAME(date_added) AS month_name,
    COUNT(*) AS total_movies,
    ROUND(AVG(profit), 0) AS avg_profit,
    SUM(CASE WHEN is_hit = 'Hit' THEN 1 ELSE 0 END) AS total_hits
FROM movie
WHERE budget > 0 AND revenue > 0
GROUP BY release_month, month_name
ORDER BY release_month;


-- =========================
-- 🎬 3. Year + Genre Trend Analysis
-- =========================

SELECT 
    m.release_year,
    g.genre,
    COUNT(*) AS total_movies,
    ROUND(AVG(m.profit), 0) AS avg_profit
FROM movie m
JOIN movie_genres g 
    ON m.title = g.title
WHERE m.budget > 0 AND m.revenue > 0
GROUP BY m.release_year, g.genre
ORDER BY m.release_year, avg_profit DESC;


-- =========================
-- 📌 Optional: Genre-wise Overall Trend
-- =========================

SELECT 
    g.genre,
    COUNT(*) AS total_movies,
    ROUND(AVG(m.profit), 0) AS avg_profit
FROM movie m
JOIN movie_genres g 
    ON m.title = g.title
GROUP BY g.genre
ORDER BY avg_profit DESC;


-- =========================
-- 📌 Final Note
-- =========================

-- Analysis covers:
-- 1. Year-wise industry performance
-- 2. Month-wise seasonal trends
-- 3. Genre evolution over time
-- 4. COVID impact on industry
-- 5. Genre performance shifts over years
