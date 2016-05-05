class CelebFestivalSchedule < ActiveRecord::Base
  belongs_to :celeb
  belongs_to :festival_schedule
end
