class Celeb < ActiveRecord::Base
  has_many :celeb_festival_schedules
  has_many :festival_schedules, through: :celeb_festival_schedules
  belongs_to :keyword
end
