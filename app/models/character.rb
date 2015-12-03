class Character < ActiveRecord::Base
  has_many :auction_items

  validates :name, presence: true
  validates :realm, presence: true
end
