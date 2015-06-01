class RevieweeTeam < ActiveRecord::Base
  validates :assignment_id, :presence => true
end