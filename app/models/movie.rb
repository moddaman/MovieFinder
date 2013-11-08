class Movie < ActiveRecord::Base

  #attr_accessor :title, :tagline, :plot, :runtime, :rating, :votes, :poster_url, :release_date

  def from_filmbuff(fb)
    self.imdb_id = fb.imdb_id
    self.title = fb.title
    self.tagline = fb.tagline
    self.plot = fb.plot
    self.runtime = fb.runtime
    self.rating = fb.rating
    self.votes = fb.votes
    self.poster_url = fb.poster_url
    self.release_date = fb.release_date
  end

end
