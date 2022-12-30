class User < ApplicationRecord
  include RatingAverage

  has_secure_password
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }, format: { with: /(?=.*[A-Z])(?=.*[0-9]).*/ }

  def favorite_beer
    return nil if ratings.empty?

    # ratings.sort_by{ |r| r.score }.last.beer
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_brewery
    return nil if ratings.empty?

    favorite = ratings.joins(:beer).group("beers.brewery_id").select("avg(score) as avg, brewery_id").order(avg: :desc).first

    Brewery.find(favorite.brewery_id)
  end

  def favorite_brewerys_name
    return nil if ratings.empty?

    favorite_brewery.name
  end

  def favorite_style
    return nil if ratings.empty?

    favorite = ratings.joins(:beer).group("beers.style").select("avg(score) as avg, style").order(avg: :desc).first

    favorite.style
  end
end
