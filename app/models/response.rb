class Response < ActiveRecord::Base
  validates :word_count, :presence => true
end