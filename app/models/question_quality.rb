class QuestionQuality < ActiveRecord::Base
  validates :question_id, :presence => true
  validates :assignment_id, :presence => true
  validates :overall_reliability, :presence => true
end