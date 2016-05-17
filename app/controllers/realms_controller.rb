class RealmsController < ApplicationController
  before_action :set_realm, only: [:show, :edit, :update, :destroy]

  def index
    @realms = Realm.includes(:characters)
                   .includes(:auction_items)
                   .order(name: :asc)
    @items_count = Item.count
    @characters_count = Character.count
    @auction_items_count = AuctionItem.count
  end

  def show
    # @top_sellers = @realm.characters
    #                      .joins(:auction_items)
    #                      .group("characters.id")
    #                      .order("count(characters.id) DESC")
    #                      .first(10)

    @top_sellers = @realm.characters.order(goods: :desc).first(10)
  end

  def new
    @realm = Realm.new
  end

  def edit
  end

  def create
    @realm = Realm.new(realm_params)

    if @realm.save
      redirect_to @realm, notice: 'Realm was successfully created.'
    else
      render :new
    end
  end

  def update
    if @realm.update(realm_params)
      redirect_to @realm, notice: 'Realm was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @realm.destroy
    redirect_to realms_url, notice: 'Realm was successfully destroyed.'
  end

  private
    def set_realm
      @realm = Realm.find(params[:id])
    end

    def realm_params
      params.require(:realm).permit(:name)
    end
end
