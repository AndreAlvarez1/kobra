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

    # KEY INDICATORS DASHBOARD - ON BASKET AND NOT PAID

    @orders_on_basket = Order.where(status:0)
    @orders_on_basket_amount = 0
    @orders_on_basket.each do |ele|
        @orders_on_basket_amount += ele.total_amount
    end

    @orders_not_paid = Order.where(status:1)
    @orders_not_paid_amount = 0
    @orders_not_paid.each do |ele|
        @orders_not_paid_amount += ele.total_amount
    end

    # MAIN GRAPH DASHBOARD - MULTIPLE STATUS OF SALES

    # ONLY LAST 3 MONTHS.
    @start_three_months_range = 2.months.ago.beginning_of_month
    @end_three_months_range = 0.months.ago.end_of_month
    @orders_on_range = Order.where('created_at BETWEEN ? AND ?', @start_three_months_range, @end_three_months_range)

    @all_orders_hash = @orders_on_range.group_by{|order| order.created_at.beginning_of_month}

    @months, @on_basquet_amounts, @not_paid_amounts, @paid_amount = [], [], [], []

    @all_orders_hash.each do |array|
      total_on_basket, total_not_paid, total_paid = 0, 0, 0
      @months << array[0].strftime("%m")
      array[1].each do |order|
        if order.status == "onbasket"
          total_on_basket += order.total_amount
        elsif order.status == "notpaid"
          total_not_paid += order.total_amount
        elsif order.status == "paid"
          total_paid += order.total_amount
        end
      end

      @on_basquet_amounts << total_on_basket
      @not_paid_amounts << total_not_paid
      @paid_amount << total_paid

    end

  end

  def dashboard
    @buyer = Buyer.new
    @search = DateFilter.new(params[:search])
    @ranking = @buyer.ranking_sales_between_dates(@search.date_from, @search.date_to)
    @names = []
    @values = []
    @ranking.each do |element|
      @names << element[0]
      @values << element[1]
    end

    # KEY INDICATORS DASHBOARD - ON BASKET AND NOT PAID

    @orders_on_basket = Order.where(status:0)
    @orders_on_basket_amount = 0
    @orders_on_basket.each do |ele|
        @orders_on_basket_amount += ele.total_amount
    end

    @orders_not_paid = Order.where(status:1)
    @orders_not_paid_amount = 0
    @orders_not_paid.each do |ele|
        @orders_not_paid_amount += ele.total_amount
    end

    # MAIN GRAPH DASHBOARD - MULTIPLE STATUS OF SALES

    # ONLY LAST 3 MONTHS.
    @start_three_months_range = 2.months.ago.beginning_of_month
    @end_three_months_range = 0.months.ago.end_of_month
    @orders_on_range = Order.where('created_at BETWEEN ? AND ?', @start_three_months_range, @end_three_months_range)

    @all_orders_hash = @orders_on_range.group_by{|order| order.created_at.beginning_of_month}

    @months, @on_basquet_amounts, @not_paid_amounts, @paid_amount = [], [], [], []

    @all_orders_hash.each do |array|
      total_on_basket, total_not_paid, total_paid = 0, 0, 0
      @months << l(array[0], format: '%B')

      array[1].each do |order|
        if order.status == "onbasket"
          total_on_basket += order.total_amount
        elsif order.status == "notpaid"
          total_not_paid += order.total_amount
        elsif order.status == "paid"
          total_paid += order.total_amount
        end
      end

      @on_basquet_amounts << total_on_basket
      @not_paid_amounts << total_not_paid
      @paid_amount << total_paid

    end

  end

  def calendar
  end

  def success
  end
end
