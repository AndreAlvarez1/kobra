class PagesController < ApplicationController
  before_action :authenticate_seller!, except:[:index,:success]

  def index
  end

  def home
  end

  def dashboard
  end

  def calendar
  end

  def success
  end
end
