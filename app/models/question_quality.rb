class QuestionQuality < ActiveRecord::Base
  validates :question_id, :presence => true
  validates :assignment_id, :presence => true
  validates :average_word_count, :presence => true
end