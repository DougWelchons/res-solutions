class CreateRelatedParts < ActiveRecord::Migration[6.1]
  def change
    create_table :related_parts do |t|
      t.references :pt1
      t.references :pt2
      t.references :pt3

      t.timestamps
    end

    add_foreign_key :related_parts, :parts, column: :pt1_id, primary_key: :id
    add_foreign_key :related_parts, :parts, column: :pt2_id, primary_key: :id
    add_foreign_key :related_parts, :parts, column: :pt3_id, primary_key: :id
  end
end
