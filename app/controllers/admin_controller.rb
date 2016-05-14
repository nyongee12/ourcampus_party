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
  end
end
