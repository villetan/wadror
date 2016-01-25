class Beer < ActiveRecord::Base
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  #def average_rating
    #summa=0
    #ratings.each{|rating| summa+=rating.score}
   # ratings.inject(0){|tulos, rating| tulos+rating.score}.fdiv(ratings.length)
  #end

  def to_s
    "#{self.name}, #{self.brewery.name}"
  end

end
