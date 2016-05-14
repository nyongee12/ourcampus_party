class AddCountToUniv < ActiveRecord::Migration
  def change
    add_column :univs, :count, :integer, default: 0
  end
end
