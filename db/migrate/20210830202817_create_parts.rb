class CreateParts < ActiveRecord::Migration[6.1]
  def change
    create_table :parts do |t|
      t.string :section_number
      t.string :first_assesment
      t.string :final_assessment
      t.float :score
      t.references :sub_section, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
