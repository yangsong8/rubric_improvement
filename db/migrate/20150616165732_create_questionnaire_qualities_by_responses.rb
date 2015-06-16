class CreateQuestionnaireQualitiesByResponses < ActiveRecord::Migration
  def change
    create_table :questionnaire_qualities_by_responses do |t|
      t.integer :questionnaire_id
      t.integer :assignment_id
      t.integer :team_id
      t.integer :response_id
      t.float :pearson
      t.float :spearman
    end
  end
end
