class HomeController < ApplicationController
  def index
    univs = Univ.where("name LIKE ?", "%#{params[:univ]}%").ids
    celebs = Celeb.where("name LIKE ?", "%#{params[:celeb]}%").ids

    # select keyword
    keyword = Keyword.where("name LIKE ?", "#{params[:keyword]}").take
    unless keyword.nil?
      univs = univs & keyword.univs.ids
    end

    # select date
    if (params[:from].nil? || params[:from] == "") && (params[:to].nil? || params[:to] == "")
      schedules = Schedule.all
    elsif params[:from].nil? || params[:from] == ""
      date = get_date(params[:to])
      schedules = Schedule.all.select { |m| m.date <= date }
    elsif params[:to].nil? || params[:to] == ""
      date = get_date(params[:from])
      schedules = Schedule.all.select { |m| m.date >= date }
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

    if params[:celeb].nil? || params[:celeb] == ""
      festivals = tmp_festivals
    else
      # select celeb
      festivals = []
      tmp_festivals.each do |f|
        status = false
        f.festival_schedules.each do |fs|
          fsc = fs.celebs.ids.count
          arr = fs.celebs.ids - celebs
          if arr.count != fsc
            status = true; break;
          end
        end
        festivals << f if status == true
      end
    end


    @fs = Kaminari.paginate_array(festivals).page(params[:page]).per(7)

  end

  def detail
    @f = Festival.find(params[:id])
  end

  def get_name

    respond_to do |format|
      format.json{
        render json: {
            result: true,
            univs: Univ.all.pluck(:name),
            celebs: Celeb.all.pluck(:name)
        }
      }
    end
  end

  def add_search
    search = Search.new
    search.univ = params[:univ]
    search.from = params[:from]
    search.to = params[:to]
    search.celeb = params[:celeb]
    search.keyword = params[:keyword]

    search.save

    # add univ count
    unless params[:univ] == ""
      Univ.all.where("name LIKE ?", "%#{params[:univ]}%").each do |u|
        u.count += 1
        u.save
      end
    end

    # add celeb count
    unless params[:celeb] == ""
      Celeb.all.where("name LIKE ?", "%#{params[:celeb]}%").each do |c|
        c.count += 1
        c.save
      end
    end

    respond_to do |format|
      format.json{
        render json: {
            result: true
        }
      }
    end
  end

  def export
    @data = Festival.all
    respond_to do |format|
      format.html
      format.csv { send_data @data.export }
    end
  end

  private
  def get_date date
    date_arr = date.split('/')
    date_arr.map! { |a| a.to_i }
    return DateTime.new(date_arr[0],date_arr[1],date_arr[2])
  end

end
