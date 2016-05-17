class AuctionItem < ActiveRecord::Base
  validates :character_id, :realm_id, :bid, :buyout, :quantity, :time_left,
            :item_id, :auc, presence: true
  belongs_to :character
  belongs_to :item
  belongs_to :realm

  scope :active, -> { where(time_left: %w(VERY_LONG LONG MEDIUM SHORT)) }
  scope :inactive, -> { where(time_left: 'NONE') }
end
