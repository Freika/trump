class Character < ActiveRecord::Base
  has_many :auction_items

  validates :name, presence: true
  validates :realm_id, presence: true
end
