module RatingAverage
  def average_rating
    extend ActiveSupport::Concern
    ratings.inject(0){|tulos, rating| tulos+rating.score}.fdiv(ratings.length)
  end
end