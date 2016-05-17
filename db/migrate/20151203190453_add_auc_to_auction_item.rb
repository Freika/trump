class AddAucToAuctionItem < ActiveRecord::Migration
  def change
    add_column :auction_items, :auc, :string, null: false, default: ''
    add_index :auction_items, :auc
  end
end
