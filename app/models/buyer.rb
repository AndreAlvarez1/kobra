class Buyer < ApplicationRecord
  belongs_to :seller
  has_many :billings, :dependent => :delete_all
  has_many :orders, :dependent => :delete_all
  has_many :products, through: :orders, :dependent => :delete_all
  mount_uploader :photo, ImageUploader


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def ranking_sales_between_dates(start_date, end_date)
    @buyers = Buyer.all
    @array = []
    @buyers.each do |buyer|
      @array << [buyer.full_name, buyer.total_sales_between_dates(start_date, end_date)]
    end
    @array = @array.sort_by { |ele| -ele[1] }
  end

  def total_sales_between_dates(start_date, end_date)
    @total_sales = 0
    billings.each do |billing|
      if (start_date <= billing.created_at) && (billing.created_at <= end_date)
        @total_sales += billing.billing_total
      end
    end
    @total_sales
  end

  def full_name
    "#{first_name} #{last_name}"
  end


end
