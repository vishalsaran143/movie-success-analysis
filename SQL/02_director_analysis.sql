-- =========================================
-- 👨‍🎬 Director Analysis
-- Dataset: Movies (2010–2025)
-- Purpose: Identify most successful directors
-- Metrics: Profit, Hit Rate, Ratings, Budget efficiency
-- =========================================


-- =========================
-- 📌 1. Profit & Hit Rate Analysis
-- =========================

SELECT 
    director,
    COUNT(DISTINCT title) AS total_movies,
    ROUND(SUM(profit), 0) AS total_profit,
    ROUND(AVG(profit), 0) AS avg_profit_per_movie,
    SUM(CASE WHEN is_hit = 'Hit' THEN 1 ELSE 0 END) AS total_hits,
    SUM(CASE WHEN is_hit = 'Flop' THEN 1 ELSE 0 END) AS total_flops,
    ROUND(
        SUM(CASE WHEN is_hit = 'Hit' THEN 1 ELSE 0 END) / 
        COUNT(DISTINCT title) * 100, 2
    ) AS hit_percentage
FROM movie
WHERE budget > 0 AND revenue > 0
GROUP BY director
HAVING COUNT(DISTINCT title) >= 2
ORDER BY total_profit DESC
LIMIT 15;


-- =========================
-- 📌 2. Rating & Popularity Analysis
-- =========================

SELECT 
    director,
    COUNT(*) AS total_movies,
    ROUND(AVG(vote_average), 2) AS avg_rating,
    ROUND(AVG(popularity), 2) AS avg_popularity
FROM movie
WHERE budget > 0 AND revenue > 0
GROUP BY director
HAVING COUNT(*) >= 2
ORDER BY avg_rating DESC
LIMIT 10;


-- =========================
-- 📌 3. Budget & Revenue Analysis
-- =========================

SELECT 
    director,
    COUNT(*) AS total_movies,
    ROUND(AVG(budget), 0) AS avg_budget,
    ROUND(AVG(revenue), 0) AS avg_revenue,
    ROUND(AVG(vote_count), 0) AS avg_votes
FROM movie
WHERE budget > 0 AND revenue > 0
GROUP BY director
HAVING COUNT(*) >= 2
ORDER BY avg_budget DESC
LIMIT 10;


-- =========================
-- 📌 Final Insight (Comment Only)
-- =========================

-- 🔍 Key Findings:
-- 1. Nolan shows strong performance in both profit and ratings
-- 2. High ratings do not always guarantee high profit
-- 3. Big-budget films are trusted to experienced directors
-- 4. Top directors outperform industry average hit rate (~63%)
-- 5. Director choice depends on goal: profit, quality, or scale
