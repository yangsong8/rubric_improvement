class CustomResponseScoreRecord < ActiveRecord::Base
  validates :assignment_id, :presence => true
  validates :question_id, :presence => true
  validates :response_id, :presence => true
  validates :reviewer_id, :presence => true
  validates :reviewee_team_id, :presence => true

  def self.say_hello
    puts "hello world"
  end
end