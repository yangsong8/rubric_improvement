class CreateQuestionQualitiesByTeams < ActiveRecord::Migration
  def change
    create_table :question_qualities_by_teams do |t|
      t.integer :assignment_id
      t.integer :question_id
      t.integer :team_id
      t.integer :liberal_agreement_num
      t.integer :conservative_agreement_num
      t.integer :rated_times
      t.float :liberal_agreement_percentage
      t.float :conservative_agreement_percentage
    end
  end
end
