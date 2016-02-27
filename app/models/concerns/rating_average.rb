module RatingAverage
  def average_rating
    extend ActiveSupport::Concern
    if ratings.empty?
      return 0

    else
      ratings.inject(0){|tulos, rating| tulos+rating.score}.fdiv(ratings.length).round(1)
    end
  end
end