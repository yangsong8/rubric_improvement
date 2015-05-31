class RevieweeTeam < ActiveRecord::Base
  validates :assignment_id, :presence => true
  validates :overall_reliability, :presence => true
end