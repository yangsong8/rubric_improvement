class Assignment < ActiveRecord::Base
  validates :questionnaire_id, :presence => true
  validates :name, :presence => true
  validates :course_id, :presence => true
  validates :course_name, :presence => true
  validates :student_num, :presence => true
  validates :reviewer_num, :presence => true
  validates :review_num, :presence => true
end