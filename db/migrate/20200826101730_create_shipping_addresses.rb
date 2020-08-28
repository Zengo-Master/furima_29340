class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string     :buyer_postal_code,   null: false
      t.integer    :buyer_prefecture,    null: false
      t.string     :buyer_city,          null: false
      t.string     :buyer_home_number,   null: false
      t.string     :buyer_building_name
      t.string     :buyer_phone_number,  null: false
      t.references :purchases,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
