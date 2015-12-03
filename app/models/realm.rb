class Realm < ActiveRecord::Base
  has_many :characters
  has_many :auction_items
  validates :name, presence: true

  def get_fresh_data
    AuctionWorker.perform_async(self.id)
  end

  def download_json
    auction_info = get_auction_url

    if self.last_modified != auction_info[:last_modified].to_s
      self.last_modified = auction_info[:last_modified].to_s
      self.save

      response = HTTParty.get(auction_info[:url])
      open("public/temp/#{self.name}.json", 'wb') do |file|
        file.write(response.body)
      end
      self.parse_json
    end
  end

  def parse_json
    file = File.read("public/temp/#{self.name}.json")
    hash = JSON.parse(file)
    hash['auctions'].each do |lot|
      owner = Character.find_or_initialize_by(
        name: lot['owner'], realm_id: self.id
      )
      owner.goods += 1
      owner.save!

      item = Item.find_or_initialize_by(wow_id: lot['item'])
      item.save

      AuctionItem.create(
        character_id: owner.id, realm_id: self.id, bid: lot['bid'],
        buyout: lot['buyout'], quantity: lot['quantity'],
        time_left: lot['timeLeft'], item_id: item.id
      )
    end
  end

  private

  def get_auction_url
    url = "https://eu.api.battle.net/wow/auction/data/#{self.name}?locale=ru_RU&apikey=#{ENV['bnet_api_key']}"
    response = HTTParty.get(url)
    {
      url: response['files'][0]['url'],
      last_modified: response['files'][0]['lastModified']
    }
  end
end
