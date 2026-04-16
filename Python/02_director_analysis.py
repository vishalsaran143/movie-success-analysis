# =========================================
#  Director Analysis
# =========================================

import pandas as pd
import plotly.express as px

df = pd.read_csv("Data/movies_cleaned.csv")

# ================================
# 📊 Top Directors by Profit
# ================================

top_dir = df.groupby('director')['profit'].sum().nlargest(10).reset_index()

fig = px.bar(top_dir, x='profit', y='director',
             orientation='h',
             title='Top 10 Directors by Total Profit',
             color='profit', color_continuous_scale='sunset')
fig.show()

# ================================
# 📊 Top Directors by Rating
# ================================

top_rating = df.groupby('director')['vote_average'].mean().nlargest(10).reset_index()

fig = px.bar(top_rating, x='director', y='vote_average',
             title='Top 10 Directors by Avg Rating',
             color='vote_average', color_continuous_scale='blues')
fig.show()

# ================================
# 📊 Hit Rate vs Industry Average
# ================================

dir_hit = df.groupby('director').apply(
    lambda x: (x['is_hit'] == 'Hit').sum() / len(x) * 100
).reset_index()
dir_hit.columns = ['director', 'hit_rate']
top_hit = dir_hit.nlargest(10, 'hit_rate')
avg = dir_hit['hit_rate'].mean()

fig = px.bar(top_hit, x='director', y='hit_rate',
             title='Hit Rate — Top Directors vs Industry Avg')
fig.add_hline(y=avg, line_dash='dash', line_color='orange',
              annotation_text=f'Industry Avg: {avg:.1f}%')
fig.show()

# ================================
# 📊 Directors Budget vs Revenue
# ================================

top_budget = df.groupby('director').agg(
    avg_budget=('budget', 'mean'),
    avg_revenue=('revenue', 'mean')
).nlargest(10, 'avg_budget').reset_index()

fig = px.bar(top_budget, x='director',
             y=['avg_budget', 'avg_revenue'],
             title='Top Directors — Avg Budget vs Revenue',
             barmode='group')
fig.show()
