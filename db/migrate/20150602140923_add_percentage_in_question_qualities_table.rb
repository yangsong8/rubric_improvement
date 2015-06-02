class AddPercentageInQuestionQualitiesTable < ActiveRecord::Migration
  def self.up
  	add_column :question_qualities, :percentage, :decimal, :precision => 20, :scale => 4
  end

  def self.down
  	remove_column :question_qualities, :percentage
  end
end
