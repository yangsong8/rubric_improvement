class Question < ActiveRecord::Base
  validates :txt, :presence => true
  validates :questionnaire_id, :presence => true
end