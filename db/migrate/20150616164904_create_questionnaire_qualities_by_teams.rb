class CreateQuestionnaireQualitiesByTeams < ActiveRecord::Migration
  def change
    create_table :questionnaire_qualities_by_teams do |t|
      t.integer :questionnaire_id
      t.integer :assignment_id
      t.integer :team_id
      t.integer :rated_times
      t.float :avg_pearson
      t.float :avg_spearman
    end
  end
end
