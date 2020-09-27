class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image
  has_many :comments, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_fee_burden
  belongs_to_active_hash :shipping_prefecture
  belongs_to_active_hash :shipping_days

  def self.search(search)
    if search != ''
      Item.where('name LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id, numericality: { other_than: 0, message: "can't be ---" }
    validates :status_id, numericality: { other_than: 0, message: "can't be ---" }
    validates :shipping_fee_burden_id, numericality: { other_than: 0, message: "can't be ---" }
    validates :shipping_prefecture_id, numericality: { other_than: 0, message: "can't be ---" }
    validates :shipping_days_id, numericality: { other_than: 0, message: "can't be ---" }
    validates :price, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width numbers.' }, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than: 10_000_000, message: 'is invalid. Input a number from 300 to 9999999.' }
  end
end
