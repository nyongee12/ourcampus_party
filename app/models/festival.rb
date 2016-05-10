class Festival < ActiveRecord::Base
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
          UnivKeyword.create(univ_id: univ.id, keyword_id: keyword.id)
        end
      end


      # create festival
      festival = Festival.create(univ_id: univ.id)

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
end
