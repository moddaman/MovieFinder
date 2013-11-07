json.array!(@movies) do |movie|
  json.extract! movie, :imdb_id, :title, :tagline, :plot, :runtime, :rating, :votes, :poster_url, :release_date
  json.url movie_url(movie, format: :json)
end