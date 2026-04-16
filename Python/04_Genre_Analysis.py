# =========================================
# Each movie can belong to multiple genres. To analyze genres accurately, the data was expanded so that each genre is treated as a separate entry.
# =========================================
# Genres explode  
df['genres'] = df['genres'].str.split(',')
df_genre = df.explode('genres')
df_genre['genres'] = df_genre['genres'].str.strip()  

# =========================================
# Top Genres by Total Profit
# =========================================
genre_profit = df_genre.groupby('genres')['profit'].sum().nlargest(10).reset_index()

fig = px.bar(genre_profit, x='profit', y='genres',
             orientation='h',
             title='Top 10 Genres by Total Profit',
             color='profit', color_continuous_scale='sunset')
fig.show()


# =========================================
#  Genre Popularity Over Years (Line)
# =========================================
genre_year = df_genre.groupby(['release_year', 'genres']).size().reset_index(name='count')

 top5_genres = df_genre['genres'].value_counts().nlargest(5).index.tolist()
genre_year_filtered = genre_year[genre_year['genres'].isin(top5_genres)]

fig = px.line(genre_year_filtered, x='release_year', y='count',
              color='genres',
              title='Top 5 Genres — Movie Count Over Years',
              markers=True)
fig.show()


# =========================================
# Genre wise Hit vs Flop Rate
# =========================================

genre_hit = df_genre.groupby('genres').apply(
    lambda x: (x['is_hit'] == 'Hit').sum() / len(x) * 100
).reset_index()
genre_hit.columns = ['genres', 'hit_rate']
genre_hit = genre_hit.nlargest(10, 'hit_rate')

fig = px.bar(genre_hit, x='genres', y='hit_rate',
             title='Genre wise Hit Rate (%)',
             color='hit_rate', color_continuous_scale='blues')
fig.add_hline(y=df_genre.groupby('genres').apply(
    lambda x: (x['is_hit'] == 'Hit').sum() / len(x) * 100).mean(),
    line_dash='dash', line_color='orange',
    annotation_text='Industry Avg')
fig.show()
