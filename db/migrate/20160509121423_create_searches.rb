class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :univ
      t.string :from
      t.string :to
      t.string :celeb
      t.string :keyword

      t.timestamps null: false
    end
  end
end
