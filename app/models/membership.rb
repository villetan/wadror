class Membership < ActiveRecord::Base
  #validates_uniqueness_of :user_id, scope: :beer_club_id
  belongs_to :beer_club
  belongs_to :user

end
