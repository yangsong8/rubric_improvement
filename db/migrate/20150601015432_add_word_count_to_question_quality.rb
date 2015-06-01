class AddWordCountToQuestionQuality < ActiveRecord::Migration
  def self.up
    add_column "question_quality","word_count",:integer
  end
end
