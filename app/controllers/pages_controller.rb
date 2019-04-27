class PagesController < ApplicationController
  before_action :authenticate_seller!, except:[:index,:success]

  def index
  end

  def home
    @buyer = Buyer.new
    @start_date = params[:start]
    @ranking = @buyer.ranking_sales_between_dates(Date.new(2018,4,30), Date.new(2019,4,30))
    @names = []
    @values = []
    @ranking.each do |element|
      @names << element[0]
      @values << element[1]
    end

    @nombre = "hola"





  end

  def dashboard
  end

  def calendar
  end

  def success
  end
end
