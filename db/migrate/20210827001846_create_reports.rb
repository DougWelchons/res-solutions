class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :name
      t.string :company
      t.integer :status

      t.timestamps
    end
  end
end
