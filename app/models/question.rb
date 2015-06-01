class Question < ActiveRecord::Base
  validates :txt, :presence => true
  validates :questionnaire_id, :presence => true
  validates :word_count, :presence => true
end