class CreateUnivs < ActiveRecord::Migration
  def change
    create_table :univs do |t|
      t.string :name
      t.string :path_link

      t.timestamps null: false
    end
  end
end
