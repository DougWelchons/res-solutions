class CreateAdditionalDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :additional_documents do |t|
      t.string :document
      t.string :notes
      t.references :user, null: false, foreign_key: true
      t.references :part, null: false, foreign_key: true

      t.timestamps
    end
  end
end
