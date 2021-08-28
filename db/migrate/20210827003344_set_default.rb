class SetDefault < ActiveRecord::Migration[6.1]
  def change
    change_column :reports, :status, :integer, default: 0
  end
end
