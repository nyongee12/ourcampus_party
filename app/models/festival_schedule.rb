class FestivalSchedule < ActiveRecord::Base
  belongs_to :festival
  belongs_to :schedule

  has_many :celeb_festival_schedules
  has_many :celebs, through: :celeb_festival_schedules
end
