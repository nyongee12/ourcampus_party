class AddCountToCeleb < ActiveRecord::Migration
  def change
    add_column :celebs, :count, :integer, default: 0
  end
end
