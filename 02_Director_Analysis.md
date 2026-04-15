# 👨‍🎬 Director Analysis: Who Makes Successful Movies?

## Overview

Choosing the right director is one of the most important factors for a movie’s success.  
In this analysis, we looked at directors from three perspectives:

- Profit & Hit Rate  
- Rating & Popularity  
- Budget & Revenue  

**Main Question:**  
Which directors are the most reliable?

---

## Query 1 — Profit & Hit Rate Analysis

**Query:**
```sql
SELECT 
    director,
    COUNT(DISTINCT title) AS total_movies,
    ROUND(SUM(profit), 0) AS total_profit,
    ROUND(AVG(profit), 0) AS avg_profit_per_movie,
    SUM(CASE WHEN is_hit = 'Hit' THEN 1 ELSE 0 END) AS total_hits,
    SUM(CASE WHEN is_hit = 'Flop' THEN 1 ELSE 0 END) AS total_flops,
    ROUND(SUM(CASE WHEN is_hit = 'Hit' THEN 1 ELSE 0 END) / 
          COUNT(DISTINCT title) * 100, 2) AS hit_percentage
FROM movie
WHERE budget > 0 AND revenue > 0
GROUP BY director
HAVING COUNT(DISTINCT title) >= 2
ORDER BY total_profit DESC
LIMIT 15;
```
**Output:**
<br>
<img width="849" height="353" alt="image" src="https://github.com/user-attachments/assets/e2d7e2e5-0c94-4c05-9a33-5054486a0af7" />


**Findings:**

- Christopher Nolan has the highest total profit and ranks #1  
- 10 directors have a 100% hit rate  
- The industry average hit rate is 63.78%  
- Top directors perform about 36% better than the industry average in terms of hit rate  


## Query 2 — Rating & Popularity Analysis

**Query:**
```sql
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
```

**Output:**
<br>
<img width="469" height="242" alt="image" src="https://github.com/user-attachments/assets/feec2e48-17da-4c2e-81a9-578719c64d61" />

**Findings:**

- Pete Docter has the highest average rating (8.01) and ranks #1  
- Nolan appears in both lists — #1 in profit and #3 in ratings  
- High ratings do not always mean high profit (Pete Docter is not in the top profit list)  
- Yang Yu appears in both lists, showing strong global performance as a Chinese director

## Query 3 — Budget & Revenue Analysis

**Query:**
```sql
SELECT 
    director,
    COUNT(*) AS total_movies,
    ROUND(AVG(budget), 0) AS avg_budget,
    ROUND(AVG(revenue), 0) AS avg_revenue,
    ROUND(AVG(vote_count), 0) AS avg_votes
FROM movies
WHERE budget > 0 AND revenue > 0
GROUP BY director
HAVING COUNT(*) >= 2
ORDER BY avg_budget DESC
LIMIT 10;
```

**Output:**

<br>
<img width="696" height="245" alt="image" src="https://github.com/user-attachments/assets/7f07e241-ce38-4def-99e2-83e6fd148b59" />

**Findings:**

- Joss Whedon gets the highest budgets, showing strong trust from studios  
- Whedon also has one of the best ROI (around 5x)  
- Higher vote count indicates wider audience reach  
- Russo Brothers and J.J. Abrams appear consistently in both lists

## 🔍 Key Insights

### Insight 1 — Nolan = Complete Package
- Profit List → #1 (highest total profit)  
- Rating List → #3 (~7.9 avg rating)  

👉 This shows he delivers both high profit and strong quality.

---

### Insight 2 — High Rating ≠ High Profit
- Pete Docter → 8.01 rating (highest), but not in profit list  
- Denis Villeneuve → 7.82 rating, also not in profit list  

👉 This shows that critical success and commercial success are not always the same.

---

### Insight 3 — Studio Trust
- Joss Whedon gets very high average budgets  
- Delivers around 5x ROI  

👉 This explains why studios trust him with big-budget projects.

---

### Insight 4 — Industry vs Top Directors
- Industry Avg Hit Rate → 63.78%  
- Top Directors Hit Rate → 100%  

👉 Top directors perform around **36% better** than the industry average.


## 💡 Final Insight

This analysis shows that there is no single best director.  
Different directors are good at different things.

Some directors make more profit, some focus on quality, and some handle big-budget movies well.

So, the director should be chosen based on the goal of the movie:
- For profit → choose a commercially successful director  
- For quality → choose a highly rated director  
- For big projects → choose a director trusted with large budgets  

👉 In short, the choice depends on what the movie wants to achieve.


## 💡 Recommendations

Based on the analysis, the following suggestions can be made:

- Choose directors like Christopher Nolan when the goal is high profit and strong overall performance  
- Choose directors like Pete Docter when the focus is on quality and ratings  
- For big-budget projects, prefer directors like Joss Whedon who are trusted and deliver high returns  
- Do not rely only on ratings — consider both profit and audience reach  
- Select directors based on the goal of the movie (profit, quality, or scale)
