class Questionnaire < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  validates :name, :presence => true
  validates :type, :presence => true
end