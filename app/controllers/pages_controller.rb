class PagesController < ApplicationController
  before_action :authenticate_seller!, except:[:index]

  def index
  end

  def home
  end

  def dashboard
  end
end
