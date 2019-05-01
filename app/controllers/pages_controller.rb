class PagesController < ApplicationController
  before_action :authenticate_seller!, except:[:index,:success]

  def index
  end

  def home
    @buyer = Buyer.new
    @search = DateFilter.new(params[:search])
    @ranking = @buyer.ranking_sales_between_dates(@search.date_from, @search.date_to)
    @names = []
    @values = []
    @ranking.each do |element|
      @names << element[0]
      @values << element[1]
    end

    # @invoices = @search.scope







  end

  def dashboard
  end

  def calendar
  end

  def success
  end
end
