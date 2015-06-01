class RenameWordCountToAverageWordCount < ActiveRecord::Migration
  def self.up
  	rename_column :question_quality, :word_count, :average_word_count
  	change_column :question_quality, :average_word_count, :decimal, :precision => 20, :scale => 4
  end

  def self.down
  	change_column :question_quality, :average_word_count, :integer
  	rename_column :question_quality, :average_word_count, :word_count
  end
end
