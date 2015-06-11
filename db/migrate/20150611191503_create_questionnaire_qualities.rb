class CreateQuestionnaireQualities < ActiveRecord::Migration
  def change
    create_table :questionnaire_quality do |t|
      t.integer :questionnaire_id
      t.integer :assignment_id
      t.float :avg_pearson
      t.float :avg_spearman
    end
  end
end
