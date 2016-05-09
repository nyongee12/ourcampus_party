class HomeController < ApplicationController
  def index
    univs = Univ.where("name LIKE ?", "%#{params[:univ]}%").pluck(:id)
    celebs = Celeb.where("name LIKE ?", "%#{params[:celeb]}%").pluck(:id)

    # select date
    if (params[:from].nil? || params[:from] == "") && (params[:to].nil? || params[:to] == "")
      schedules = Schedule.all
    elsif params[:from].nil? || params[:from] == ""
      date = get_date(params[:to])
      schedules = Schedule.where(date: date)
    elsif params[:to].nil? || params[:to] == ""
      date = get_date(params[:from])
      schedules = Schedule.where(date: date)
    else
      from_date = get_date(params[:from])
      to_date = get_date(params[:to])

      schedules = Schedule.all.select { |m| m.date >= from_date && m.date <= to_date }
    end



    # select univ
    tmp_festivals = []
    schedules.each do |s|
      tmp_festivals += s.festivals.where(univ_id: univs)
    end

    tmp_festivals.uniq!

    # select celeb
    festivals = []
    tmp_festivals.each do |f|
      status = false
      f.festival_schedules.each do |fs|
        fsc = fs.celebs.pluck(:id).count
        arr = fs.celebs.pluck(:id) - celebs
        if arr.count != fsc
          status = true; break;
        end
      end
      festivals << f if status == true
    end

    @fs = Kaminari.paginate_array(festivals).page(params[:page]).per(7)

  end

  def detail
    @f = Festival.find(params[:id])
  end

  private
  def get_date date
    date_arr = date.split('/')
    date_arr.map! { |a| a.to_i }
    return DateTime.new(date_arr[0],date_arr[1],date_arr[2])
  end

end
