class User < ActiveRecord::Base
  include RatingAverage
  has_secure_password
  validates :username, uniqueness: true,
            length: {minimum: 3,
            maximum: 15}
  validates :password, length: {minimum: 4}
  validates_format_of :password, :with => /(?=.*\d)(?=.*([A-Z]))/



  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    ratings.group_by{|ra| ra.beer.style}
        .map{|s,r| {s => r.map(&:score).sum / r.size.to_f}}
        .max_by{|item| item.values}.keys.first rescue nil
  end

  def favorite_brewery
    return nil if ratings.empty?
    best_brewery_id=ratings.group_by{|ra| ra.beer.brewery.id}.
        map{|s,r| {s=> r.map(&:score).sum / r.size.to_f}}
                        .max_by{|item| item.values}.keys.first
    Brewery.all.select{|b| b.id==best_brewery_id}.first
  end

  def self.top(n)
    highest_raters=User.all.sort_by{|u| -(u.ratings.count)}.take(n)

  end

end
