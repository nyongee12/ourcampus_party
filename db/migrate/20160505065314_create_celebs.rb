class CreateCelebs < ActiveRecord::Migration
  def change
    create_table :celebs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
