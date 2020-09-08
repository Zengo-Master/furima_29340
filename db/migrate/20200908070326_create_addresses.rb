class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :prefecture_id
      t.string :name

      t.timestamps
    end
  end
end
