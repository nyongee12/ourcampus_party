class CreateCelebFestivalSchedules < ActiveRecord::Migration
  def change
    create_table :celeb_festival_schedules do |t|
      t.integer :festival_schedule_id
      t.integer :celeb_id

      t.timestamps null: false
    end
  end
end
