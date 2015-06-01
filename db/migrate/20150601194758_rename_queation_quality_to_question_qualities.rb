class RenameQueationQualityToQuestionQualities < ActiveRecord::Migration
  def self.up
  	rename_table :question_quality, :question_qualities
  end

  def self.down
  	rename_table :question_qualities, :question_quality
  end
end
