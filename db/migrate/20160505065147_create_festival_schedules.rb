class CreateFestivalSchedules < ActiveRecord::Migration
  def change
    create_table :festival_schedules do |t|
      t.integer :festival_id
      t.integer :schedule_id

      t.timestamps null: false
    end
  end
end
