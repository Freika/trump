class RemoveOwnerRealmAndAddRealmId < ActiveRecord::Migration
  def change
    remove_column :auction_items, :owner_realm
    add_column :auction_items, :realm_id, :integer, null: false, default: 0
    add_index :auction_items, :realm_id
  end
end
