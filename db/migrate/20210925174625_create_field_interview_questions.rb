class CreateFieldInterviewQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :field_interview_questions do |t|
      t.string :question
      t.string :notes
      t.references :part, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
