class CreateSubSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sub_sections do |t|
      t.string :section_number
      t.string :name
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
