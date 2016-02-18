class PlacesController < ApplicationController


  def index
  end

  def show


    city=params[:city]
    place_id=params[:id]

    @place = Rails.cache.read("#{city}").select{|p| p.id==place_id}.first
    byebug
    render :show
    #place.send(params) tämä kuulema viewiin?
  end


  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end