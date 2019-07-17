class Food < ApplicationRecord
  belongs_to :food_category
  has_many :comment_foods
  has_many :order_datails

  validates :name, presence: true
  validates :price, presence: true
end
