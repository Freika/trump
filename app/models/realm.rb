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
      update(last_modified: auction_info[:last_modified].to_s)

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
    auc_ids = hash['auctions'].map { |a| a['auc'] }

    AuctionItem.active.each do |item|
      unless auc_ids.include?(item.auc)
        item.update(time_left: 'NONE')
      end
    end

    hash['auctions'].each do |lot|
      owner = Character.find_or_initialize_by(
        name: lot['owner'], realm_id: id
      )
      owner.goods += 1
      owner.save!

      item = Item.get_and_save(lot['item'])

      AuctionItemWorker.perform_async(lot, item.id, owner.id, id)
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
