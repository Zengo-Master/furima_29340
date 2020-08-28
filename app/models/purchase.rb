class Purchase < ApplicationRecord
  belongs_to :user
  belongs to :item
  has_one :shipping_address

end
