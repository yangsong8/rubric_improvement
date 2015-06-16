class NewColumnsInQuestionQualities < ActiveRecord::Migration
  def change
    add_column :question_qualities, :liberal_agreement_num, :integer
    add_column :question_qualities, :conservative_agreement_num, :integer
    add_column :question_qualities, :rated_times, :integer
    add_column :question_qualities, :liberal_agreement_percentage, :float
    add_column :question_qualities, :conservative_agreement_percentage, :float
    remove_column :question_qualities, :overall_reliability
    remove_column :question_qualities, :percentage
  end
end
