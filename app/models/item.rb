class Item < ActiveRecord::Base
  has_many :auction_items

  validates :wow_id, presence: true, uniqueness: true

  def self.get_and_save(item_id)
    item = Item.find_or_initialize_by(wow_id: item_id)

    remote_item = Wowrb.item(item_id)

    item.name = remote_item['name']
    item.save

    item
  end
end
