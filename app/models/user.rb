class User < ActiveRecord::Base

  has_many :ratings
  has_many :movies

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :listed_movies, foreign_key: "user_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :movie_collection, through: :listed_movies, source: :movie
  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name:  "Relationship",
           dependent:   :destroy

  has_many :followers, through: :reverse_relationships, source: :follower


  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 8 }


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  def follow_movie(movie)
    listed_movies.create!(movie_id: movie.id, user_id: self.id)
  end

  def following_movie?(movie)
    listed_movies.find_by(movie_id: movie.id)
  end

  def unfollow_movie!(movie)
    listed_movies.find_by(movie_id: movie.id).destroy!
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def top_rated
    all_rated_movies = ratings.where.not(:score => 0).all
    all_rated_movies = all_rated_movies.sort { |a,b| a.score <=> b.score }
    all_rated_movies.reverse!
    all_rated_movies.take(10)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
