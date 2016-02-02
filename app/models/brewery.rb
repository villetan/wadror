class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :year, numericality: {greater_than_or_equal_to: 1042}
  validate :less_than_or_equal_to_current_year, on: :create

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers



  def less_than_or_equal_to_current_year
    if self.year>DateTime.now.year
      errors.add(:year, "can't be greater than current year (#{DateTime.now.year})")
    end
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2016
    puts "changed year to #{year}"
  end

  #def average_rating
   #ratings.inject(0) { |tulos, rating | tulos+ rating.score }.fdiv(self.ratings.length)
  #end

end
