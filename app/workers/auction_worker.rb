class AuctionWorker
  include Sidekiq::Worker

  def perform(realm_id)
    realm = Realm.find(realm_id)
    realm.download_json
  end
end
