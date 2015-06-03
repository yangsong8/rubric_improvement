class AddTwoColumnsToAssignments < ActiveRecord::Migration
  def self.up
  	add_column :assignments, :undergraduate, :integer
  	add_column :assignments, :programming, :integer
  end

  def self.down
  	remove_column :assignments, :programming
  	remove_column :assignments, :undergraduate
  end
end
