## 📅 Year & Month Analysis: When Do Movies Succeed?
# 📌 Overview

Release timing plays a crucial role in a movie’s overall success.
This analysis explores movie performance from three key perspectives:

- 📊 Year-wise profit trends (2010–2025)
- 📆 Month-wise profit patterns (seasonality analysis)
- 🎬 Year + Genre trends (identifying growing and declining genres over time)
## Main Question

What is the optimal time to release a movie for maximum success and profitability?

## Query 1 — Year Wise Analysis

**Query:**
```sql
SELECT 
    release_year,
    COUNT(*) AS total_movies,
    ROUND(SUM(profit), 0) AS total_profit,
    ROUND(AVG(profit), 0) AS avg_profit,
    SUM(CASE WHEN is_hit = 'Hit' THEN 1 ELSE 0 END) AS hits,
    SUM(CASE WHEN is_hit = 'Flop' THEN 1 ELSE 0 END) AS flops
FROM movie
WHERE budget > 0 AND revenue > 0
GROUP BY release_year
ORDER BY release_year ASC;
```
**Output**
<br>
<img width="560" height="385" alt="image" src="https://github.com/user-attachments/assets/9e283c62-805b-4831-b6b9-2b01052ef1f3" />


**Findings**
### Growth Phase (2010–2019)
- 2010 avg profit → 5.1 Cr  
- 2019 avg profit → 9.5 Cr (Best Year!)

- The film industry showed nearly 2x growth over 9 years, indicating a strong and consistent upward trend in profitability and audience demand.


### COVID Crash (2020)
- Movies released → 286 → 118 (↓ 59%)  
- Average profit  → 9.5 Cr → 1.4 Cr (↓ 85%)  
- Flops           → 66 vs 52 hits

### The industry faced a severe downturn due to:

- Theatre closures worldwide
- Delayed and cancelled releases
- Shift towards OTT platforms

- This led to a major drop in revenue and an increase in flops

### Recovery Phase (2021–2025)
- 2021 → 4.9 Cr (Recovery begins)  
- 2022 → 6.5 Cr (Strong rebound)  
- 2023 → 6.5 Cr (Stable performance)  
- 2025 → 9.3 Cr (Near pre-COVID peak)

- The industry showed a strong recovery over four years, gradually stabilizing and returning close to pre-pandemic performance levels.

### **Insight**

The movie industry is very sensitive to big outside events like COVID-19, but it can also recover well. Even though it dropped heavily in 2020, it slowly improved and came back close to its best level in about 4–5 years.


## Query 2 — Month Wise Analysis (Season Pattern)

**Query:**
```sql
SELECT 
    MONTH(date_added) AS release_month,
    MONTHNAME(date_added) AS month_name,
    COUNT(*) AS total_movies,
    ROUND(AVG(profit), 0) AS avg_profit,
    SUM(CASE WHEN is_hit = 'Hit' THEN 1 ELSE 0 END) AS hits
FROM movie
WHERE budget > 0 AND revenue > 0
GROUP BY release_month, month_name
ORDER BY release_month ASC;
```
**Output**
<br>

<img width="545" height="294" alt="image" src="https://github.com/user-attachments/assets/22178db6-ab78-41c6-a376-fbace141129b" />

**Findings**
## Seasonality Pattern of Movie Success
### Summer Season (Peak Performance)
- June  → 12.8 Cr avg profit (Highest)
- July  → 10 Cr avg profit

## Reason:

- School and college vacations
- More free time for audiences
- Higher cinema attendance

### Summer is the strongest season for profitability

## Holiday Season (High Engagement)
- December → 9.2 Cr avg profit
- December → 227 hits (Highest number of hits)

## Reason:

- Christmas and New Year holidays
- Family audiences increase
- Big-budget and family movies perform better

### Best season for family and festive releases

## Weak Season (Low Performance)
- August    → 3.6 Cr avg profit
- September → 3.2 Cr avg profit (Lowest)
- October   → 4.7 Cr avg profit
- September → 410 movies released (Highest competition)

## Reason:

- Too much competition
- Low audience turnout
- Many releases but poor performance

## September is the worst month for releases

# Best Release Strategy
-  For Blockbusters → Release in June
-  For Maximum Hits → Release in December
-  or Family Movies → November–December is ideal
-  Avoid releasing in September (high risk, low return)

## Query 3 — Year + Genre Trend

**Query:**
```sql
SELECT 
    m.release_year,
    g.genre,
    COUNT(*) AS total_movies,
    ROUND(AVG(m.profit), 0) AS avg_profit
FROM movie m
JOIN movie_genres g ON m.title = g.title
WHERE m.budget > 0 AND m.revenue > 0
GROUP BY m.release_year, g.genre
ORDER BY m.release_year ASC, avg_profit DESC;
```


**Output:**

| Year | Genre | Total Movies | Avg Profit |
|------|-------|-------------|------------|
| 2010 | Animation | 16 | 194,110,403 |
| 2010 | Family | 31 | 162,900,861 |
| 2010 | Adventure | 48 | 156,270,344 |
| 2010 | Fantasy | 35 | 136,365,696 |
| 2010 | Science Fiction | 18 | 101,555,512 |
| 2010 | Action | 73 | 64,023,349 |
| 2010 | Western | 3 | 48,979,667 |
| 2010 | Comedy | 113 | 45,404,753 |
| 2010 | Romance | 65 | 37,585,761 |
| 2010 | History | 15 | 32,431,049 |
| 2010 | Thriller | 73 | 28,556,732 |
| 2010 | Horror | 33 | 28,246,618 |
| 2010 | Mystery | 28 | 28,030,968 |
| 2010 | Drama | 146 | 26,985,887 |
| 2010 | Documentary | 5 | 20,380,637 |
| 2010 | Crime | 45 | 16,101,999 |
| 2010 | War | 8 | 9,706,198 |
| 2010 | Music | 7 | -2,619,000 |
| 2010 | TV Movie | 1 | -2,690,420 |
| 2011 | Fantasy | 25 | 177,223,359 |
| 2011 | Adventure | 41 | 170,296,224 |
| 2011 | Animation | 20 | 155,649,500 |
| 2011 | Family | 31 | 116,514,120 |
| 2011 | Science Fiction | 26 | 111,831,310 |
| 2011 | Mystery | 22 | 75,492,200 |
| 2011 | Action | 75 | 71,831,695 |
| 2011 | Music | 8 | 64,269,078 |
| 2011 | Comedy | 110 | 63,212,264 |
| 2011 | Western | 2 | 61,261,163 |
| 2011 | Crime | 31 | 46,875,843 |
| 2011 | Romance | 53 | 44,102,259 |
| 2011 | Thriller | 75 | 42,730,567 |
| 2011 | Horror | 28 | 23,999,413 |
| 2011 | Drama | 143 | 23,066,892 |
| 2011 | Documentary | 7 | 19,015,075 |
| 2011 | History | 14 | 17,384,550 |
| 2011 | War | 9 | 3,787,506 |
| 2011 | TV Movie | 1 | 750,000 |
| 2012 | Adventure | 39 | 236,978,067 |
| 2012 | Western | 2 | 177,386,223 |
| 2012 | Fantasy | 24 | 171,994,863 |
| 2012 | Animation | 19 | 153,320,200 |
| 2012 | Science Fiction | 25 | 153,201,826 |
| 2012 | Family | 25 | 122,449,442 |
| 2012 | Action | 72 | 103,696,748 |
| 2012 | History | 10 | 75,862,419 |
| 2012 | Thriller | 75 | 60,208,230 |
| 2012 | Comedy | 98 | 59,837,020 |
| 2012 | Crime | 39 | 51,519,977 |
| 2012 | Drama | 128 | 48,112,773 |
| 2012 | Romance | 49 | 40,923,773 |
| 2012 | Horror | 26 | 29,270,723 |
| 2012 | Mystery | 14 | 27,801,112 |
| 2012 | Music | 9 | 26,818,538 |
| 2012 | Documentary | 4 | 13,242,408 |
| 2012 | War | 10 | -1,407,290 |
| 2013 | Family | 18 | 247,336,409 |
| 2013 | Animation | 19 | 217,008,936 |
| 2013 | Science Fiction | 28 | 177,496,517 |
| 2013 | Adventure | 42 | 176,203,338 |
| 2013 | Fantasy | 24 | 160,120,176 |
| 2013 | Action | 69 | 118,164,739 |
| 2013 | War | 2 | 98,614,001 |
| 2013 | Comedy | 71 | 68,263,715 |
| 2013 | Crime | 51 | 51,648,509 |
| 2013 | Horror | 32 | 49,889,154 |
| 2013 | Thriller | 80 | 46,308,923 |
| 2013 | History | 12 | 39,334,424 |
| 2013 | Western | 3 | 27,339,414 |
| 2013 | Drama | 138 | 26,831,742 |
| 2013 | Romance | 36 | 23,669,318 |
| 2013 | Mystery | 15 | 17,871,246 |
| 2013 | Documentary | 5 | 13,453,370 |
| 2013 | Music | 8 | 7,431,809 |
| 2014 | Science Fiction | 33 | 211,667,283 |
| 2014 | Adventure | 49 | 201,101,039 |
| 2014 | Action | 72 | 153,704,658 |
| 2014 | War | 9 | 152,433,331 |
| 2014 | Fantasy | 24 | 122,586,175 |
| 2014 | Family | 32 | 122,150,625 |
| 2014 | Animation | 21 | 116,055,443 |
| 2014 | History | 8 | 64,620,348 |
| 2014 | Comedy | 95 | 64,008,328 |
| 2014 | Thriller | 61 | 59,148,491 |
| 2014 | Mystery | 15 | 57,225,356 |
| 2014 | Drama | 132 | 39,553,011 |
| 2014 | Horror | 26 | 38,788,567 |
| 2014 | Romance | 44 | 36,181,915 |
| 2014 | Crime | 33 | 29,880,641 |
| 2014 | Music | 8 | 28,511,899 |
| 2014 | Western | 3 | 8,235,606 |
| 2015 | Science Fiction | 28 | 264,102,817 |
| 2015 | Adventure | 55 | 215,600,134 |
| 2015 | Action | 68 | 168,156,595 |
| 2015 | Animation | 23 | 143,889,505 |
| 2015 | Family | 31 | 121,157,376 |
| 2015 | Thriller | 61 | 96,644,272 |
| 2015 | Western | 6 | 83,308,127 |
| 2015 | Fantasy | 28 | 73,386,625 |
| 2015 | Comedy | 89 | 70,714,940 |
| 2015 | Crime | 35 | 69,175,881 |
| 2015 | Romance | 35 | 45,935,746 |
| 2015 | Music | 12 | 44,929,708 |
| 2015 | Drama | 129 | 42,647,201 |
| 2015 | History | 20 | 36,666,784 |
| 2015 | Mystery | 18 | 28,369,129 |
| 2015 | Horror | 29 | 23,556,742 |
| 2015 | War | 9 | 5,495,112 |
| 2016 | Animation | 22 | 234,261,671 |
| 2016 | Family | 30 | 220,440,394 |
| 2016 | Fantasy | 29 | 201,626,689 |
| 2016 | Adventure | 73 | 179,385,571 |
| 2016 | Science Fiction | 21 | 171,343,358 |
| 2016 | Music | 8 | 143,467,263 |
| 2016 | Action | 86 | 100,084,246 |
| 2016 | Comedy | 88 | 99,563,162 |
| 2016 | Mystery | 19 | 52,671,244 |
| 2016 | Romance | 35 | 52,114,984 |
| 2016 | Horror | 33 | 40,584,829 |
| 2016 | Western | 3 | 29,340,224 |
| 2016 | Thriller | 73 | 28,758,267 |
| 2016 | Drama | 146 | 28,462,188 |
| 2016 | War | 13 | 26,904,937 |
| 2016 | Crime | 41 | 22,908,390 |
| 2016 | History | 25 | 18,320,473 |
| 2016 | Documentary | 1 | 13,700,000 |
| 2017 | Fantasy | 28 | 221,509,095 |
| 2017 | Adventure | 59 | 189,769,677 |
| 2017 | Science Fiction | 31 | 173,419,065 |
| 2017 | Family | 33 | 161,696,040 |
| 2017 | Music | 6 | 152,310,524 |
| 2017 | Action | 81 | 151,644,521 |
| 2017 | Animation | 23 | 143,328,313 |
| 2017 | War | 17 | 87,994,304 |
| 2017 | Romance | 35 | 84,513,942 |
| 2017 | Comedy | 75 | 78,291,271 |
| 2017 | Horror | 33 | 71,308,623 |
| 2017 | Crime | 40 | 64,534,188 |
| 2017 | Thriller | 74 | 58,332,194 |
| 2017 | Drama | 131 | 40,249,625 |
| 2017 | Mystery | 28 | 37,546,782 |
| 2017 | History | 25 | 16,837,278 |
| 2017 | Documentary | 3 | 3,551,604 |
| 2017 | Western | 1 | -18,023,664 |
| 2018 | Science Fiction | 33 | 245,657,003 |
| 2018 | Music | 7 | 191,819,740 |
| 2018 | Adventure | 66 | 187,840,184 |
| 2018 | Action | 78 | 171,173,959 |
| 2018 | Animation | 19 | 170,127,979 |
| 2018 | Fantasy | 27 | 127,869,726 |
| 2018 | Family | 27 | 122,616,333 |
| 2018 | Romance | 23 | 74,276,862 |
| 2018 | Comedy | 75 | 65,492,206 |
| 2018 | Horror | 33 | 58,572,893 |
| 2018 | War | 11 | 55,867,249 |
| 2018 | Thriller | 71 | 52,951,820 |
| 2018 | Mystery | 23 | 41,647,217 |
| 2018 | Drama | 108 | 34,687,431 |
| 2018 | Crime | 42 | 28,493,577 |
| 2018 | History | 25 | 19,440,471 |
| 2018 | Documentary | 2 | -2,508,940 |
| 2018 | Western | 1 | -24,856,944 |
| 2019 | Animation | 19 | 289,280,580 |
| 2019 | Adventure | 52 | 265,719,179 |
| 2019 | Science Fiction | 23 | 264,859,083 |
| 2019 | Family | 28 | 221,356,191 |
| 2019 | Fantasy | 31 | 193,182,583 |
| 2019 | Action | 61 | 140,661,430 |
| 2019 | Comedy | 77 | 90,895,146 |
| 2019 | Romance | 23 | 74,089,863 |
| 2019 | Crime | 28 | 65,181,334 |
| 2019 | Horror | 32 | 57,363,692 |
| 2019 | Thriller | 67 | 57,019,304 |
| 2019 | Drama | 98 | 50,796,886 |
| 2019 | Music | 6 | 48,211,033 |
| 2019 | History | 22 | 41,294,042 |
| 2019 | War | 12 | 27,755,444 |
| 2019 | Mystery | 20 | 27,664,168 |
| 2019 | Western | 3 | -5,402,443 |
| 2020 | War | 4 | 86,753,225 |
| 2020 | Crime | 14 | 51,114,282 |
| 2020 | Thriller | 31 | 39,635,248 |
| 2020 | Action | 43 | 37,678,983 |
| 2020 | Animation | 12 | 30,634,439 |
| 2020 | History | 11 | 26,032,923 |
| 2020 | Science Fiction | 20 | 17,856,726 |
| 2020 | Fantasy | 21 | 15,765,072 |
| 2020 | Comedy | 38 | 7,652,730 |
| 2020 | Horror | 28 | 7,134,123 |
| 2020 | Drama | 46 | 5,746,712 |
| 2020 | Family | 21 | 4,378,134 |
| 2020 | Romance | 12 | 168,244 |
| 2020 | Mystery | 8 | -126,883 |
| 2020 | Adventure | 28 | -5,244,769 |
| 2020 | Music | 3 | -17,140,733 |
| 2020 | Western | 2 | -19,151,270 |
| 2021 | War | 4 | 165,973,868 |
| 2021 | Science Fiction | 23 | 137,307,732 |
| 2021 | Adventure | 44 | 104,973,860 |
| 2021 | Action | 49 | 91,877,059 |
| 2021 | Music | 4 | 69,042,766 |
| 2021 | Comedy | 41 | 52,161,838 |
| 2021 | Fantasy | 23 | 51,106,147 |
| 2021 | Mystery | 17 | 49,850,950 |
| 2021 | Animation | 18 | 44,974,725 |
| 2021 | Horror | 21 | 43,548,290 |
| 2021 | Family | 21 | 38,107,452 |
| 2021 | Thriller | 37 | 33,943,683 |
| 2021 | Crime | 24 | 19,757,036 |
| 2021 | Drama | 68 | 18,997,445 |
| 2021 | Documentary | 1 | -2,687,771 |
| 2021 | History | 13 | -4,574,826 |
| 2021 | Western | 2 | -8,955,902 |
| 2021 | Romance | 14 | -9,170,178 |
| 2022 | Science Fiction | 21 | 186,557,972 |
| 2022 | Action | 51 | 150,945,615 |
| 2022 | Adventure | 45 | 147,759,416 |
| 2022 | War | 4 | 90,752,818 |
| 2022 | Animation | 16 | 74,367,270 |
| 2022 | Documentary | 1 | 70,340,218 |
| 2022 | Family | 22 | 68,892,218 |
| 2022 | Fantasy | 29 | 55,978,963 |
| 2022 | Comedy | 50 | 53,812,150 |
| 2022 | History | 14 | 50,035,408 |
| 2022 | Music | 6 | 46,099,883 |
| 2022 | Crime | 24 | 41,989,873 |
| 2022 | Mystery | 27 | 41,144,370 |
| 2022 | Drama | 72 | 31,991,826 |
| 2022 | Horror | 39 | 24,502,503 |
| 2022 | Thriller | 52 | 23,477,695 |
| 2022 | Romance | 18 | 14,571,064 |
| 2022 | Western | 1 | -20,535,802 |
| 2023 | Animation | 20 | 160,819,737 |
| 2023 | Family | 20 | 156,146,684 |
| 2023 | Adventure | 43 | 150,318,958 |
| 2023 | Science Fiction | 24 | 124,115,813 |
| 2023 | Fantasy | 28 | 117,618,574 |
| 2023 | Action | 59 | 76,501,909 |
| 2023 | Comedy | 65 | 69,512,191 |
| 2023 | War | 9 | 67,709,145 |
| 2023 | Horror | 26 | 66,034,990 |
| 2023 | Music | 5 | 55,500,735 |
| 2023 | Mystery | 18 | 54,449,139 |
| 2023 | Thriller | 52 | 44,313,109 |
| 2023 | Crime | 27 | 42,556,317 |
| 2023 | History | 23 | 36,844,408 |
| 2023 | Romance | 24 | 34,544,367 |
| 2023 | Documentary | 1 | 29,029,271 |
| 2023 | Drama | 84 | 26,577,388 |
| 2024 | Animation | 15 | 318,416,333 |
| 2024 | Family | 17 | 316,519,029 |
| 2024 | Science Fiction | 24 | 189,470,159 |
| 2024 | Adventure | 30 | 170,007,137 |
| 2024 | Comedy | 57 | 117,861,524 |
| 2024 | Action | 54 | 78,558,132 |
| 2024 | Fantasy | 17 | 72,114,482 |
| 2024 | Romance | 19 | 47,102,062 |
| 2024 | Horror | 43 | 42,698,754 |
| 2024 | Drama | 86 | 28,062,509 |
| 2024 | Thriller | 62 | 27,150,462 |
| 2024 | Crime | 29 | 26,549,452 |
| 2024 | Mystery | 13 | 18,956,577 |
| 2024 | Music | 8 | 11,626,545 |
| 2024 | War | 6 | 4,648,608 |
| 2024 | History | 15 | 4,029,453 |
| 2024 | Documentary | 2 | -2,698,420 |
| 2024 | Western | 1 | -11,764,298 |
| 2025 | Adventure | 1 | 1,910,000,000 |
| 2025 | Animation | 2 | 979,096,073 |
| 2025 | Fantasy | 4 | 494,180,931 |
| 2025 | Science Fiction | 3 | 43,867,237 |
| 2025 | Action | 9 | 24,317,842 |
| 2025 | Family | 2 | 22,346,073 |
| 2025 | Comedy | 6 | 20,732,184 |
| 2025 | Thriller | 8 | 20,324,965 |
| 2025 | War | 2 | 15,967,500 |
| 2025 | Crime | 2 | 15,003,155 |
| 2025 | Mystery | 1 | 13,010,725 |
| 2025 | History | 1 | 13,000,000 |
| 2025 | Horror | 6 | 12,638,238 |
| 2025 | Romance | 4 | 5,793,493 |
| 2025 | Drama | 10 | 2,590,178 |



## Rising Genres
### Animation
- Consistently Top 3 performer
- 2010: 19.4 Cr → 2024: 31.8 Cr
- (Stable + highest reliability)

### Science Fiction
- Fastest growing genre
- 2010: 10.1 Cr → 2022: 18.6 Cr
- (Technology-driven popularity increase)

### Family
- Strong supporting genre
- Always performs well with Animation
- (High audience engagement: kids + parents)

## Stable Genres
- Action     → Always in Top 5
- Adventure  → Consistent strong performer
- Comedy     → Stable but moderate profit range

# Declining Genres
- Western → Strong in early years (e.g., #2 in 2012)
          Declined heavily and turned negative by 2024

- Documentary → Low frequency releases
              Consistently low profit performance

## COVID Impact on Genres (2020)
- Music     → -1.7 Cr (live events stopped)
- Western   → -1.9 Cr
- Adventure → -0.5 Cr

- War       → 8.6 Cr (performed on OTT platforms)
- Crime     → 5.1 Cr (thriller + OTT-friendly content)

## Key Insights Summary
## Insight 1 — Best Year
- 2019 → Best performing year
- Avg profit: 9.5 Cr (Peak level)
- Industry was at its highest before COVID disruption
## Insight 2 — COVID Impact
- 2020 → ~85% industry drop
- Recovery period: 2021–2024
- Full stabilization took ~4 years
## Insight 3 — Best Month
- June     → Highest profit (12.8 Cr avg)
- December → Highest hits (227 movies)
- September → Worst performance (3.2 Cr avg)
## Insight 4 — Genre Trend
- Animation + Family → Most reliable combo
- Science Fiction    → Fastest growing genre
- Western            → Declining / dying genre
