class Character < ActiveRecord::Base
  has_many :auction_items, dependent: :destroy

  validates :name, presence: true
  validates :realm_id, presence: true
end
