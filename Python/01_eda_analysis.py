# =========================================
# 📊 EDA Analysis
# =========================================

import pandas as pd
import plotly.express as px

# Load dataset
df = pd.read_csv("Data/movies_cleaned.csv")

# ================================
# 📊 Graph 1 — Movies per Year
# ================================

year_count = df['release_year'].value_counts().sort_index().reset_index()
year_count.columns = ['Year', 'Count']

fig = px.bar(year_count, x='Year', y='Count',
             title='Movies Released Per Year',
             color='Count', color_continuous_scale='reds')
fig.show()

# ================================
# 📊 Graph 2 — Hit vs Flop
# ================================
fig = px.pie(df, names='is_hit',
             title='Hit vs Flop Ratio',
             color_discrete_map={'Hit': 'green', 'Flop': 'red'},
             hole=0.4)
fig.show()
