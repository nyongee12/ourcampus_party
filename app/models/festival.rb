class Festival < ActiveRecord::Base
  belongs_to :univ
  has_many :festival_schedules
  has_many :schedules, through: :festival_schedules

  accepts_nested_attributes_for :festival_schedules

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      festival_hash = row.to_hash
      festival = Festival.find_or_create_by(id: festival_hash[:id])
      festival.update_attributes(festival_hash)
    end
  end
end
