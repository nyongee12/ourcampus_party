class CelebFestivalSchedule < ActiveRecord::Base
  belongs_to :celeb
  belongs_to :festival_schedule

  accepts_nested_attributes_for :celeb
end
