class AddMoreColumnsToQuestionnaires < ActiveRecord::Migration
  def change
    add_column :questionnaires, :num_questions, :integer
    add_column :questionnaires, :num_tf_questions, :integer
    add_column :questionnaires, :num_single_complete_questions, :integer
    add_column :questionnaires, :num_spot_check_questions, :integer
    add_column :questionnaires, :num_non_rating_questions, :integer
  end
end
