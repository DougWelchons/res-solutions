class UpdateColumnInParts < ActiveRecord::Migration[6.1]
  def change
    remove_column :parts, :first_assesment, :string
    add_column :parts, :first_assessment, :string
  end
end
