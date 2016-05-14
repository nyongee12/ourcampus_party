class VisitorController < ApplicationController
  def intro

    @univs = Univ.order(count: :desc).first(3)
    @celebs = Celeb.order(count: :desc).first(3)

  end
end
