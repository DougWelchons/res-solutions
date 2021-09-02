class RemoveColumnFromSection < ActiveRecord::Migration[6.1]
  def change
    remove_column :sections, :section_number, :string
  end
end
