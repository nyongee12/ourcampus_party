class AdminController < ApplicationController
  include ApplicationHelper
  layout "admin_layout"
  def index
    @rows = []
    Festival.all.each do |f|
      @rows << make_row(f)
    end
  end

  def show
  end

  def new

  end

  def edit
    festival = Festival.find(params[:id])
    @id = params[:id]
    @from = festival.schedules.first.date.strftime("%Y/%m/%d")
    @to = festival.schedules.last.date.strftime("%Y/%m/%d")
    @univ = festival.univ.name
    @days = []
    0.upto(4) do |idx|
      fs = festival.festival_schedules[idx]
      if fs.nil?
        @days << ""
      else
        @days << fs.celebs.pluck(:name).join(",")
      end
    end
  end

  def update
    h = Hash.new
    h["id"] = params[:id]
    h["univ"] = params[:univ]
    params[:from].split("/").last
    h["schedules"]
  end
end
