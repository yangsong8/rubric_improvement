class AddWordCountInQuestionsTable < ActiveRecord::Migration
  def self.up
  	add_column :questions, :word_count, :integer
  end

  def self.down
  	remove_column :questions, :word_count, :integer
  end
end
