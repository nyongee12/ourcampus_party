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

      # create or select univ
      univ = Univ.find_or_create_by(name: festival_hash["univ"].strip)

      # create keyword
      unless festival_hash["keyword"].nil? || festival_hash["keyword"] == ""
        festival_hash["keyword"].split(",").each do |k|
          keyword = Keyword.find_or_create_by(name: k.strip)
          UnivKeyword.find_or_create_by(univ_id: univ.id, keyword_id: keyword.id)
        end
      end

      # destroy about festival
      festival = Festival.where(id: festival_hash["id"]).take
      unless festival.nil?
        festival.festival_schedules.each do |fs|
          fs.celeb_festival_schedules.each { |cfs| cfs.destroy }
          fs.destroy
        end
        festival.destroy
      end


      # create festival
      festival = Festival.find_or_create_by(id: festival_hash["id"])
      festival.univ = univ
      festival.save

      # create festival_schedule
      festival_hash["schedules"].split(",").each do |s|
        schedule_id = s.strip.to_i-8
        FestivalSchedule.find_or_create_by(festival_id: festival.id, schedule_id: schedule_id)
      end

      # create celeb & celeb_festival_schedule
      festival.festival_schedules.each_with_index do |fs, idx|
        str = festival_hash["day#{idx+1}"]
        next if str.nil?
        str.split(",").each do |s|
          celeb = Celeb.find_or_create_by(name: s.strip)
          CelebFestivalSchedule.find_or_create_by(festival_schedule_id: fs.id, celeb_id: celeb.id)
        end
      end

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
