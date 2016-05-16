module ApplicationHelper
  # def button_with_form(text, type= :text)
      
  #     return '' unless text
      
  #     case type
  #       when :text
  #         format = 
  #     end
  # end

  def isNil(str)
    result = (str.nil? || str == "") ? true : false
    return result
  end

  def make_row f
    values = []

    # create festival_id
    values << f.id
    # create univ
    values << f.univ.name

    # create keyword
    values << f.univ.keywords.pluck(:name).join(",")

    # create schedules
    days = ""
    f.schedules.each { |s| days += "#{s.date.strftime("%d")}," }
    values << days

    # create celebs
    1.upto(5) do |idx|
      s = f.schedules[idx-1]
      if s.nil?
        values << ""
        next
      end
      fs = s.festival_schedules.where(festival_id: f.id).take
      values << fs.celebs.pluck(:name).join(",")
    end
    return values
  end

  def make_festival festival_hash
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
      schedule = Schedule.find_or_create_by(date: DateTime.new(2016,05,s.to_i))
      # schedule_id = s.strip.to_i-8
      FestivalSchedule.find_or_create_by(festival_id: festival.id, schedule_id: schedule.id)
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
