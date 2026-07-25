class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  validates :email, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true
  validates :shipping_city, presence: true
  validates :shipping_state, presence: true
  validates :shipping_zip, presence: true
end
