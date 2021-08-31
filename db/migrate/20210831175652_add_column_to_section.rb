class AddColumnToSection < ActiveRecord::Migration[6.1]
  def change
    add_column :sections, :section_number, :string
  end
end
