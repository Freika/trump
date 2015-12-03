class Item < ActiveRecord::Base
  has_many :auction_items

  validates :wow_id, presence: true, uniqueness: true
end
