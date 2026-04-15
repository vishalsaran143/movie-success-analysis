# 📊 Data Exploration & Cleaning

## 1. Dataset Overview

This dataset is taken from Kaggle and contains movie data from 2010 to 2025.  
Before starting the analysis, it was important to understand and clean the data properly.

---
## 📌 Step 1 — Dataset Overview

First, I checked the total number of rows and columns in the dataset.

**Query:**
```sql
SELECT COUNT(*) FROM movies;
DESCRIBE movies;
```
**Output:**

Total Rows: 3500  
Total Columns: 14

Finding:
The dataset contains 3500 movies with 14 columns covering the years 2010 to 2025.


## 📌 Step 2 — Column Details

Next, I explored what each column represents and identified the important ones for analysis.

| Column        | Type    | Description              |
|--------------|---------|--------------------------|
| title        | text    | Movie name               |
| director     | text    | Director name            |
| cast         | text    | Main actors              |
| date_added   | text    | Release date             |
| release_year | bigint  | Movie release year       |
| rating       | double  | Movie rating             |
| genres       | text    | Movie genre              |
| popularity   | double  | Popularity score         |
| vote_count   | bigint  | Total votes              |
| vote_average | double  | Average rating           |
| budget       | bigint  | Movie budget             |
| revenue      | bigint  | Movie earnings           |

**Finding:**

- Budget and revenue are numeric → suitable for analysis  
- Genres were later exploded because one movie can have multiple genres



## 📌 Step 3 — NULL Values Check

Checked whether the dataset contains any missing values.
Analyzed minimum and maximum values to understand data range.

**Query""
```sql
SELECT
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS null_title,
    SUM(CASE WHEN director IS NULL THEN 1 ELSE 0 END) AS null_director,
    SUM(CASE WHEN cast IS NULL THEN 1 ELSE 0 END) AS null_cast,
    SUM(CASE WHEN budget IS NULL THEN 1 ELSE 0 END) AS null_budget,
    SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) AS null_revenue
FROM movie;
```
**Output**
<br>

<img width="497" height="57" alt="image" src="https://github.com/user-attachments/assets/92770a8e-1231-4bad-b63d-b33ac796b1ae" />


**Finding:**
- No NULL values were found — the dataset is clean at this stage.

## 📌 Step 4 — Min/Max Analysis

Analyzed minimum and maximum values to understand data range.
**Query:**
```sql
SELECT 
    MIN(budget) AS min_budget,
    MAX(budget) AS max_budget,
    MIN(revenue) AS min_revenue,
    MAX(revenue) AS max_revenue,
    MIN(popularity) AS min_popularity,
    MAX(popularity) AS max_popularity,
    MIN(vote_average) AS min_vote_avg,
    MAX(vote_average) AS max_vote_avg,
    MIN(release_year) AS min_year,
    MAX(release_year) AS max_year
FROM movie;
```

**Output:**
<br> 
![preview](https://github.com/user-attachments/assets/6e5ebbd1-7107-4d8c-911a-6e4313b2cd32)

**Finding:**

- Minimum budget = 5 → suspicious ⚠️
- Minimum revenue = 200 → suspicious ⚠️
- Maximum budget = 460M
- Maximum revenue = 2.79B

## 📌 Step 5 — Investigating Suspicious Data

Some movies had unrealistically low budgets, so they were examined.

**Query:**
```sql
SELECT title, budget, revenue 
FROM movie
WHERE budget < 1000;
```

**Output** 
<br>
<img width="920" height="257" alt="image" src="https://github.com/user-attachments/assets/29ce9cca-b217-4075-b61f-59c4fbe39760" />

**Finding:**

- 5 movies had budgets between 5 and 200
- These values are unrealistic compared to the rest of the dataset
- Likely data entry errors

## 📌 Step 6 — Data Cleaning

Removed unrealistic rows to improve data quality.

**Query:**
```sql 
DELETE FROM movie WHERE budget < 1000;

SELECT COUNT(*) AS final_rows FROM movie;
```
**Output:**

| final_rows |
|------------|
| 3495       |


**Finding:**

- 5 rows removed successfully
- Final dataset = 3495 movies


## 📌 Step 7 — Outlier Analysis & Decision Making

Before analyzing outliers, we first removed unrealistic budget records to improve data quality.

---

### 🧹 Initial Data Cleaning (Before Outlier Analysis)

**Action Taken:**
We removed extremely low budget entries which were likely data errors.

**Query:**

```sql
DELETE FROM movies 
WHERE budget < 1000;

SELECT COUNT(*) AS final_rows 
FROM movie;

```

**Output:**

| final_rows |
|------------|
| 3495       |


**Finding:**

- 5 unrealistic rows were removed successfully
- Final dataset contains 3495 movies
- This ensured cleaner and more reliable outlier detection

## 💰 Budget Outliers

**Query:**
```sql
SELECT title, budget 
FROM movies 
WHERE budget > (
    SELECT AVG(budget) + 3 * STD(budget) 
    FROM movie
)
ORDER BY budget DESC;
```

**Output:**
<br>
<img width="557" height="349" alt="image" src="https://github.com/user-attachments/assets/eb378bb3-d264-4959-8e7d-33d55f43d966" />

**Finding:**

- These are high-budget blockbuster films
- Not data errors, but real production scale movies
- Hence, kept in dataset (not removed)


## 💸 Revenue Outliers
**Query:**
```sql
SELECT title, revenue 
FROM movies 
WHERE revenue > (
    SELECT AVG(revenue) + 3 * STD(revenue) 
    FROM movie
)
ORDER BY revenue DESC;
```
**Output:**
<br>
<img width="489" height="136" alt="image" src="https://github.com/user-attachments/assets/712633a0-55c2-4e7e-9fdc-965e07b27c50" />

**Finding:**

- These movies are recent releases (2024–2025), so their popularity is naturally high due to current hype and audience interest.  
Because of this, we considered them valid data points and did not remove them.

## 📈 Popularity Outliers
**Query:**
```sql
SELECT title, popularity 
FROM movie
WHERE popularity > (
    SELECT AVG(popularity) + 3 * STD(popularity) 
    FROM movie
)
ORDER BY popularity DESC;
```

**Output:**
<br> 
<img width="530" height="347" alt="image" src="https://github.com/user-attachments/assets/3adf73f2-483a-43f7-a799-8cb582685e1a" />

**Finding:**

- Since these are recent movies (2024–2025), their popularity is naturally higher because of hype and audience interest.  
So we kept them as valid data points instead of removing them.


## **💡 Final Insight:**

We avoided removing outliers blindly. Instead, we reviewed each case to see whether it was a data issue or a real-world pattern.  

Some values were genuine blockbuster cases, while only actual errors were considered for removal.


## 4️⃣  Step 7 - Feature Engineering

After cleaning and outlier analysis, new features were created to make the dataset more insightful and analysis-ready.

---

### 🛠️ New Columns Created

#### 📌 Column 1: profit
```sql
ALTER TABLE movie ADD COLUMN profit BIGINT;

UPDATE movie
SET profit = revenue - budget;

SELECT title,budget FROM movie;
```
**Output:**
<br>
<img width="555" height="130" alt="image" src="https://github.com/user-attachments/assets/ef8de1e8-6086-4e39-bf44-6659c5f5ee6c" />

## 📌 Column 2: roi (Return on Investment)
**Query:**
```sql
ALTER TABLE movie ADD COLUMN roi DECIMAL(10,2);

UPDATE movie 
SET roi = (profit / budget) * 100;
```

**Output:**
<br>
<img width="520" height="156" alt="image" src="https://github.com/user-attachments/assets/6fb5d716-8b68-4d5d-b9f4-e5edeafeb464" />

## 📌 Column 3: is_hit
**Query:**
```sql
ALTER TABLE movie ADD COLUMN is_hit VARCHAR(10);

UPDATE movie
SET is_hit = CASE 
    WHEN profit > 0 THEN 'Hit' 
    ELSE 'Flop' 
END;
```
**Output:**
<br>
<img width="517" height="178" alt="image" src="https://github.com/user-attachments/assets/9523c127-8110-4caa-a331-68d3c91f08a4" />

## 5️⃣ Final Dataset Statistics

After completing data cleaning and feature engineering, the dataset is fully prepared for analysis.

---

- **Total Rows:** 3,495 (after removing 5 invalid records)  
- **Total Columns:** 17 (14 original + 3 new features)  
- **Missing Values:** 0 (complete dataset)  
- **Data Quality:** ~98.75% (very minimal data loss during cleaning)
