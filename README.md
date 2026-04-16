# 🎬 Movie Success Analysis

## Problem Statement
Every year, thousands of movies are released, but only a few become successful. 
This project analyzes movie data to identify the key factors that affect a movie’s success.

## Dataset
- Total Movies: 3495 (after cleaning)
- Time Period: 2010 - 2025
- Source: Kaggle

## Tools Used
- MySQL  → Data Analysis
- Python → Visualization

## Project Structure
📁 SQL/     → All SQL queries
📁 Python/  → All graphs
📁 Data/    → Cleaned dataset

## Key Insights
# 🎯 Key Insights & Recommendations

> **3,495 movies | 2010–2025 | 5 actionable insights**

---

## 1️⃣ Low Budget = Highest ROI 💰

| Budget | ROI | Risk |
|--------|-----|------|
| Under $50M | **1000–2000%** | High risk, high reward |
| $50M–$100M | 300–500% | Medium |
| $100M+ | 100–300% | Safe, stable |

**→ Mix small & big budget projects for best portfolio balance.**

---

## 2️⃣ Top Directors = 36% Better Hit Rate 🎬

```
Industry Average  →  63.78%
Top Directors     →  100%
```
Christopher Nolan = #1 Profit + #3 Rating → Best all-rounder.

**→ Always check director's past hit rate before investing.**

---

## 3️⃣ Adventure = Most Reliable Genre 🏆

- **Highest profit** → Adventure ($130B) & Action ($115B)
- **Highest hit rate** → Family (77%) → Animation (74%) → Adventure (72%)

Adventure is the only genre that tops **both** lists.

**→ Want profit + consistency? Bet on Adventure.**

---

## 4️⃣ COVID Killed 85% Revenue — Recovered in 4 Years 📉

```
2019  →  9.5 Cr avg profit  (Peak)
2020  →  1.4 Cr avg profit  (85% drop)
2024  →  9.3 Cr avg profit  (Recovery)
```

**→ Always have an OTT/streaming backup plan for crisis.**

---

## 5️⃣ High Rating ≠ High Profit ⭐

| Director | Rating | Profit Rank |
|----------|--------|-------------|
| Pete Docter | 8.01 (Highest) | ❌ Not in top 10 |
| Christopher Nolan | 7.9 | ✅ #1 |

**→ Track profit & rating as separate goals — not the same thing.**

---

## ✅ The 3-Rule Formula

> **Right Director + Right Genre + Right Timing = Hit Movie**

| Rule | Action |
|------|--------|
| 🎬 Director | Hit rate > 80% |
| 🎭 Genre | Adventure or Family |
| 📅 Timing | Release in June, avoid September |


# Graphs

## Budget vs ROI Analysis
<img width="1340" height="525" alt="budget_roi" src="https://github.com/user-attachments/assets/602bfca7-d58b-41a2-982d-b1b5f17996e9" />

- This graph shows the relationship between movie budget and ROI.
- It clearly indicates that low to mid-budget movies often generate higher ROI compared to high-budget films, showing that efficiency matters more than spending.
  
## Director Hit Rate Analysis
<img width="1568" height="603" alt="preview (1)" src="https://github.com/user-attachments/assets/f189ed7d-21ae-480c-99ee-3e9e5d9737a5" />

- This graph shows that financial success and consistency go hand in hand. The most profitable directors also have a hit rate well above the industry average.
- This means top directors are not just lucky — they consistently deliver strong results.

## Top 10 Genres by Profit
<img width="1340" height="525" alt="genre_profit" src="https://github.com/user-attachments/assets/1e9f5c02-c7cb-4f57-98f5-6f96f4ff5360" />

- This bar chart shows the most profitable movie genres.
- Genres like Adventure and Action dominate overall profit generation, indicating strong audience preference and commercial success.

## Genre Performance Over Years
<img width="1340" height="525" alt="genre_year" src="https://github.com/user-attachments/assets/efc945b9-b991-44ca-b7b4-6d8d16a2d0d0" />

- This line chart shows how different genres performed over time.
- It clearly captures trend shifts, including COVID impact and post-pandemic recovery, along with changing audience preferences across years.
