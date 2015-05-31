class CreateCustomResponseScoreRecords < ActiveRecord::Migration
  def self.up
    create_table :custom_response_score_records do |t|
      t.integer :assignment_id
      t.integer :question_id
      t.integer :score
      t.text :comments
      t.integer :response_id
      t.integer :reviewer_id
      t.integer :reviewee_team_id

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :custom_response_score_records
  end
end