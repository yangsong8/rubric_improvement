class ChangeTheOverallReliabilityType < ActiveRecord::Migration
  def self.up
  	change_column :assignments, :overall_reliability, :decimal, :precision => 20, :scale => 4
  	change_column :question_quality, :overall_reliability, :decimal, :precision => 20, :scale => 4
  	change_column :reviewee_teams, :overall_reliability, :decimal, :precision => 20, :scale => 4
  end
end
