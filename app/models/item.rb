class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :category
  # belongs_to_active_hash :status
  # belongs_to_active_hash :fee
  # belongs_to_active_hash :prefecture
  # belongs_to_active_hash :days

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category, numericality: { other_than: 0, message: "can't be blank" } 
    validates :status, numericality: { other_than: 0, message: "can't be blank" } 
    validates :shipping_fee_burden, numericality: { other_than: 0, message: "can't be blank" } 
    validates :shipping_prefecture, numericality: { other_than: 0, message: "can't be blank" } 
    validates :shipping_days, numericality: { other_than: 0, message: "can't be blank" } 
    validates :price, format: { with: /\A[0-9]+\z/, message: "is invalid. Input half-width numbers." }, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than: 10000000, message: "is invalid. Input a number from 300 to 9999999." }
  end

end
