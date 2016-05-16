class Festival < ActiveRecord::Base

  require 'csv'
  belongs_to :univ
  has_many :festival_schedules
  has_many :schedules, through: :festival_schedules

  accepts_nested_attributes_for :festival_schedules

  # default_scope { order('festival.schedules.id ASC') }

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      festival_hash = row.to_hash

      ApplicationController.helpers.make_festival(festival_hash)

    end
  end

  def self.export
    CSV.generate() do |csv|
      csv.add_row %w(id univ keyword schedules day1 day2 day3 day4 day5)

      all.each do |f|
        csv.add_row ApplicationController.helpers.make_row(f)
      end
    end
  end
end
