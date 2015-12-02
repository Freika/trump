class RealmsController < ApplicationController
  before_action :set_realm, only: [:show, :edit, :update, :destroy]

  # GET /realms
  def index
    @realms = Realm.all
  end

  # GET /realms/1
  def show
  end

  # GET /realms/new
  def new
    @realm = Realm.new
  end

  # GET /realms/1/edit
  def edit
  end

  # POST /realms
  def create
    @realm = Realm.new(realm_params)

    if @realm.save
      redirect_to @realm, notice: 'Realm was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /realms/1
  def update
    if @realm.update(realm_params)
      redirect_to @realm, notice: 'Realm was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /realms/1
  def destroy
    @realm.destroy
    redirect_to realms_url, notice: 'Realm was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_realm
      @realm = Realm.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def realm_params
      params.require(:realm).permit(:name)
    end
end
