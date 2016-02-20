class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  #validates :style, presence: true
  validates :style_id, presence: true

  belongs_to :style
  belongs_to :brewery
  belongs_to :user
  has_many :ratings, dependent: :destroy
  has_many :raters, ->{uniq}, through: :ratings, source: :user



  #def average_rating
    #summa=0
    #ratings.each{|rating| summa+=rating.score}
   # ratings.inject(0){|tulos, rating| tulos+rating.score}.fdiv(ratings.length)
  #end

  def to_s
    "#{self.name}, #{self.brewery.name}"
  end

end
