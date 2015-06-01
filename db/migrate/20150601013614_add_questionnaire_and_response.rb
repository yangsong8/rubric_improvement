class AddQuestionnaireAndResponse < ActiveRecord::Migration
  def self.up
    create_table :questionnaires do |t|
      t.string :name
      t.string :type
    end

    create_table :responses do |t|
      t.integer :word_count
    end
  end
end
