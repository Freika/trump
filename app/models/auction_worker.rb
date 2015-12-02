class AuctionWorker
  include Sidekiq::Worker
  def perform(name)
    # do something
  end
end
