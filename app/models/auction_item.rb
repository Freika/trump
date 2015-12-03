class AuctionItem < ActiveRecord::Base
  belongs_to :character_id
  belongs_to :item
  belongs_to :realm
end
