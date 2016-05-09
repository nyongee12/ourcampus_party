class CreateUnivKeywords < ActiveRecord::Migration
  def change
    create_table :univ_keywords do |t|
      t.integer :univ_id
      t.integer :keyword_id

      t.timestamps null: false
    end
  end
end
