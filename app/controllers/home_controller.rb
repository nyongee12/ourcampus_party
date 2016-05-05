class HomeController < ApplicationController
  def index
    univs = Univ.where("name LIKE ?", "%#{params[:univ]}%").pluck(:id)
    celebs = Celeb.where("name LIKE ?", "%#{params[:celeb]}%").pluck(:id)

    # select date
    if (params[:from].nil? || params[:from] == "") && (params[:to].nil? || params[:to] == "")
      schedules = Schedule.all
    elsif params[:from].nil? || params[:from] == ""
      schedules = Schedule.find([params[:to], params[:to]])
      @to = Schedule.find(params[:to]).date
    elsif params[:to].nil? || params[:to] == ""
      schedules = Schedule.find([params[:from], params[:from]])
      @from = Schedule.find(params[:from]).date
    else
      schedules = Schedule.find([params[:from], params[:to]])
      @to = Schedule.find(params[:to]).date
      @from = Schedule.find(params[:from]).date
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

    @fs = Kaminari.paginate_array(festivals).page(params[:page]).per(2)
  end

  def detail
    @f = Festival.find(params[:id])
  end
end
