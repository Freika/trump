class Realm < ActiveRecord::Base
  has_many :characters, dependent: :destroy
  has_many :auction_items, dependent: :destroy
  validates :name, presence: true

  def refresh_data
    AuctionWorker.perform_async(id)
  end

  def download_json
    auction_info = get_auction_url

    if last_modified != auction_info[:last_modified].to_s
      last_modified = auction_info[:last_modified].to_s
      save

      response = HTTParty.get(auction_info[:url])
      open("public/temp/#{name}.json", 'wb') do |file|
        file.write(response.body)
      end

      parse_json
    end
  end

  def parse_json
    file = File.read("public/temp/#{name}.json")
    hash = JSON.parse(file)
    hash['auctions'].each do |lot|
      owner = Character.find_or_initialize_by(
        name: lot['owner'], realm_id: id
      )
      owner.goods += 1
      owner.save!

      item = Item.get_and_save(lot['item'])

      auction_item = AuctionItem.find_or_create_by(auc: lot['auc'])
      unless auction_item.persisted?
        AuctionItem.create(
          character_id: owner.id,
          realm_id: id,
          bid: lot['bid'],
          buyout: lot['buyout'],
          quantity: lot['quantity'],
          time_left: lot['timeLeft'],
          item_id: item.id,
          auc: lot['auc']
        )
      end
    end
  end

  private

  def get_auction_url
    response = Wowrb.auction_url(name)
    {
      url: response['files'].first['url'],
      last_modified: response['files'].first['lastModified']
    }
  end
end
