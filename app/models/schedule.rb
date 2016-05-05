class Schedule < ActiveRecord::Base
  has_many :festival_schedules
  has_many :festivals, through: :festival_schedules
end
