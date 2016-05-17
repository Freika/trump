class AuctionItemWorker
  include Sidekiq::Worker

  def perform(lot, item_id, owner_id, realm_id)
    auction_item = AuctionItem.find_or_create_by(auc: lot['auc'])
    unless auction_item.persisted?
      AuctionItem.create(
        character_id: owner_id,
        realm_id: realm_id,
        bid: lot['bid'],
        buyout: lot['buyout'],
        quantity: lot['quantity'],
        time_left: lot['timeLeft'],
        item_id: item_id,
        auc: lot['auc']
      )
    end
  end
end
