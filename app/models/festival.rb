class Festival < ActiveRecord::Base
  belongs_to :univ
  has_many :festival_schedules
  has_many :schedules, through: :festival_schedules
end
