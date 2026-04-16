# =========================================
# 💼 Business Analysis
# =========================================

import pandas as pd
import plotly.express as px

df = pd.read_csv("Data/movies_cleaned.csv")

# ================================
# 📊 Budget vs Revenue
# ================================

fig = px.scatter(df, x='budget', y='revenue',
                 color='is_hit',
                 title='Budget vs Revenue',
                 hover_data=['title'],
                 color_discrete_map={'Hit': 'green', 'Flop': 'red'})
fig.show()

# ================================
# 📊 Budget vs ROI
# ================================
df_clean = df[(df['roi'] < 2000) & (df['roi'].notna())]

fig = px.scatter(df_clean, x='budget', y='roi',
                 color='is_hit',
                 title='Budget vs ROI',
                 hover_data=['title'],
                 color_discrete_map={'Hit': 'green', 'Flop': 'red'})
fig.add_hline(y=0, line_dash='dash', line_color='yellow',
              annotation_text='Break-even')
fig.show()
