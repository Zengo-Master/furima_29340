class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase

  validates :name, presence: true

end
