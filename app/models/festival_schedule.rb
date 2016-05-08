class FestivalSchedule < ActiveRecord::Base
  belongs_to :festival
  belongs_to :schedule

  has_many :celeb_festival_schedules
  has_many :celebs, through: :celeb_festival_schedules

  accepts_nested_attributes_for :schedule
  accepts_nested_attributes_for :celeb_festival_schedules

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      fs_hash = row.to_hash

      fs_hash["schedules"].split(",").each do |s|
        schedule_id = s.to_i-8
        FestivalSchedule.find_or_create_by(festival_id: fs_hash["festival_id"], schedule_id: schedule_id)
      end

    end
  end
end
