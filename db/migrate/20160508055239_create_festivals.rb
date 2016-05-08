class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.integer :univ_id

      t.timestamps null: false
    end
  end
end
