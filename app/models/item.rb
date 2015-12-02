class Item < ActiveRecord::Base
  validates :wow_id, presence: true, uniqueness: true
end
