module ApplicationHelper
  # def button_with_form(text, type= :text)
      
  #     return '' unless text
      
  #     case type
  #       when :text
  #         format = 
  #     end
  # end
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
end
