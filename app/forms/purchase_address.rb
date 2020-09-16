class PurchaseAddress

  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :buyer_postal_code, :buyer_prefecture_id, :buyer_city, :buyer_home_number, :buyer_building_name, :buyer_phone_number, :purchase_id, :token

  with_options presence: true do
    validates :buyer_postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :buyer_prefecture_id, numericality: { other_than: 0, message: "can't be ---" }
    validates :buyer_city
    validates :buyer_home_number
    validates :buyer_phone_number, format: { with: /\A\d{,11}\z/, message: "is invalid. Input numbers within 11 digits without a hyphen(-)." }
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(buyer_postal_code: buyer_postal_code, buyer_prefecture_id: buyer_prefecture_id, buyer_city: buyer_city, buyer_home_number: buyer_home_number, buyer_building_name: buyer_building_name, buyer_phone_number: buyer_phone_number, purchase_id: purchase.id)
  end
end