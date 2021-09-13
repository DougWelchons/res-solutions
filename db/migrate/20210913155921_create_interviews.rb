class CreateInterviews < ActiveRecord::Migration[6.1]
  def change
    create_table :interviews do |t|
      t.date :date
      t.time :time
      t.string :stakeholder
      t.string :attendees
      t.string :background
      t.string :interview
      t.string :report_summery
      t.references :section, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
