class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details

  validates :address, presence: true
  validates :total_money, presence: true
end
