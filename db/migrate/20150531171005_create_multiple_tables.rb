class CreateMultipleTables < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :questionnaire_id
      t.string :name
      t.integer :course_id
      t.string :course_name
      t.integer :student_num
      t.integer :reviewer_num
      t.integer :review_num
      t.float :overall_reliability
    end
    
    create_table :question_quality do |t|
      t.integer :question_id
      t.integer :assignment_id
      t.float :overall_reliability
    end

    create_table :questions do |t|
      t.text :txt
      t.integer :questionnaire_id
    end

    create_table :reviewee_teams do |t|
      t.integer :assignment_id
      t.float :overall_reliability
    end

    end
  end
end
