class Style < ActiveRecord::Base
  has_many :beers
  has_many :ratings, through: :beers
  include RatingAverage


  def self.top(n)
    styles=Style.all
    best_beers = styles.sort_by{ |b| -(b.average_rating||0) }.take(n)
  end
end
