class ListedMovie < ActiveRecord::Base

  belongs_to :user, class_name: "User"
  belongs_to :movie, class_name: "Movie"

  validates :user_id, presence: true, uniqueness: true
  validates :movie_id, presence: true, uniqueness: true

end
