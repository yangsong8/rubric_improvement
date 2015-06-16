class RenameQuestionnaireQuality < ActiveRecord::Migration
  def change
    rename_table :questionnaire_quality, :questionnaire_qualities
    add_column :questionnaire_qualities, :team_id, :integer
  end
end
