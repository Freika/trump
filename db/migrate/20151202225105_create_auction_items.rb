class CreateAuctionItems < ActiveRecord::Migration
  def change
    create_table :auction_items do |t|
      t.integer :character_id
      t.integer :item_id
      t.string :name, null: false, default: ''
      t.string :bid, default: ''
      t.string :buyout, default: ''
      t.string :owner_realm, null: false, default: ''
      t.integer :quantity, default: 0
      t.string :time_left, null: false, default: ''

      t.timestamps null: false
    end
    add_index :auction_items, :character_id
    add_index :auction_items, :item_id
    add_index :auction_items, :bid
    add_index :auction_items, :buyout
    add_index :auction_items, :quantity
  end
end
