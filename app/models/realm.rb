class Realm < ActiveRecord::Base
  validates :name, presence: true

  def download_json
    url = get_auction_url
    response = HTTParty.get(url)
    open("public/temp/#{self.name}.json", 'wb') do |file|
      file.write(response.body)
    end
  end

  def parse_json
    file = File.read("public/temp/#{self.name}.json")
    hash = JSON.parse(file)
    hash['auctions'].each do |lot|
      owner = Character.find_or_initialize_by(
        name: lot['owner'], realm: lot['ownerRealm']
      )
      owner.goods += 1
      owner.save!

      item = Item.find_or_initialize_by(wow_id: lot['item'])
      item.save

      AuctionItem.create(
        character_id: owner.id, owner_realm: owner.realm, bid: lot['bid'],
        buyout: lot['buyout'], quantity: lot['quantity'],
        time_left: lot['timeLeft']
      )
    end
  end

  private

  def get_auction_url
    url = "https://eu.api.battle.net/wow/auction/data/#{self.name}?locale=ru_RU&apikey=#{ENV['bnet_api_key']}"
    response = HTTParty.get(url)
    response['files'][0]['url']
  end
end
