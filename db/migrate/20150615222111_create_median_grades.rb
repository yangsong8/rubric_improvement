class CreateMedianGrades < ActiveRecord::Migration
  def change
    create_table :median_grades do |t|
      t.integer :team_id
      t.integer :question_id
      t.float :median
    end
  end
end
