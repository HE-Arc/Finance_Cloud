class User < ActiveRecord::Base
  has_many :articles
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_secure_password
  before_save {self.email = email.downcase}

  validates :username,
            presence: true,
            length: {minimum: 3, maximum: 15},
            uniqueness: {case_sensitive: false}

  validates :password,
            presence: true,
            length: {minimum: 6, maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: {minimum: 3, maximum: 100},
            uniqueness: {case_sensitive: false},
            format: { with: VALID_EMAIL_REGEX }

  validates :rank,
            numericality: { less_than_or_equal_to: 999 }

  def add_stock?(ticker)
    at_stock_limit? && !already_added_stock?(ticker)
  end

  def at_stock_limit?
    (user_stocks.count < 50)
  end

  def already_added_stock?(ticker)
    stock = Stock.retrieve_stock_by_ticker(ticker)
    return false unless stock
    user_stocks.where(stock_id: stock.id).exists?
  end
end
