class Movie < ActiveRecord::Base

  validates :search_title, presence: true, uniqueness: true

  has_many :ratings
  belongs_to :user

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
    self.search_title = fb.title.downcase
  end

  def average_rating
    ratings.sum(:score) / ratings.size
  end

end
