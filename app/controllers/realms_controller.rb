class RealmsController < ApplicationController
  before_action :set_realm, only: [:show, :edit, :update, :destroy]

  def index
    @realms = Realm.all.order(name: :asc)
  end

  def show
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
