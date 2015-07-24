class AdvertisementsController < ApplicationController
  def index
    # Checkpoint #33 ("CRUD") assignement
    @ads = Advertisement.all
  end

  def show
    # Checkpoint #33 ("CRUD") assignement
    @ad = Advertisement.find(params[:id])
  end
end
