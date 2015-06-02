class AddThreeFieldsToQuestionsTable < ActiveRecord::Migration
  def self.up
  	add_column :questions, :tf, :integer
  	add_column :questions, :single_complete, :integer
  	add_column :questions, :spot_check, :integer
  end

  def self.down
  	remove_column :questions, :spot_check, :integer
  	remove_column :questions, :single_complete, :integer
  	remove_column :questions, :tf, :integer
  end
end
