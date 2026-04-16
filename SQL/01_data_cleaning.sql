-- =========================================
-- 📊 Movie Dataset - Data Exploration & Cleaning
-- Dataset: Movies (2010–2025)
-- Purpose: Data understanding, cleaning & feature engineering
-- =========================================


-- =========================
-- 📌 1. Dataset Overview
-- =========================

-- Total number of records
SELECT COUNT(*) AS total_rows 
FROM movie;

-- Table structure
DESCRIBE movie;


-- =========================
-- 📌 2. Null Value Analysis
-- =========================

SELECT
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS null_title,
    SUM(CASE WHEN director IS NULL THEN 1 ELSE 0 END) AS null_director,
    SUM(CASE WHEN budget IS NULL THEN 1 ELSE 0 END) AS null_budget,
    SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) AS null_revenue
FROM movie;


-- =========================
-- 📌 3. Data Range Analysis
-- =========================

SELECT
    MIN(budget) AS min_budget,
    MAX(budget) AS max_budget,
    MIN(revenue) AS min_revenue,
    MAX(revenue) AS max_revenue,
    MIN(release_year) AS min_year,
    MAX(release_year) AS max_year
FROM movie;


-- =========================
-- 📌 4. Data Cleaning
-- =========================

-- Remove invalid budget entries (data errors)
DELETE FROM movie
WHERE budget < 1000;

-- Verify cleaned dataset size
SELECT COUNT(*) AS final_rows 
FROM movie;


-- =========================
-- 📌 5. Outlier Detection (Budget)
-- =========================

SELECT 
    title, 
    budget
FROM movie
WHERE budget > (
    SELECT AVG(budget) + 3 * STD(budget)
    FROM movie
)
ORDER BY budget DESC;


-- =========================
-- 📌 6. Feature Engineering
-- =========================

-- Profit calculation
ALTER TABLE movie 
ADD COLUMN profit BIGINT;

UPDATE movie
SET profit = revenue - budget;


-- ROI calculation
ALTER TABLE movie 
ADD COLUMN roi DECIMAL(10,2);

UPDATE movie
SET roi = (profit / budget) * 100;


-- Hit / Flop classification
ALTER TABLE movie 
ADD COLUMN is_hit VARCHAR(10);

UPDATE movie
SET is_hit = CASE 
    WHEN profit > 0 THEN 'Hit'
    ELSE 'Flop'
END;


-- =========================
-- 📌 Final Note
-- =========================

-- Dataset cleaned successfully
-- Removed invalid records (budget < 1000)
-- No missing values found
-- Dataset ready for analysis & visualization
