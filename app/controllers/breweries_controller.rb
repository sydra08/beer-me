class BreweriesController < ApplicationController
  def index
    @brewery = Brewery.new
    @breweries = Brewery.alpha_sorted

    # render json: @breweries, each_serializer: BreweryShowSerializer
    respond_to do |format|
      # apparently order matters here
      format.json {render json: @breweries, each_serializer: BrewerySerializer}
      format.html {render :index}
    end
  end

  def show
    @brewery = Brewery.find_by(id: params[:id])

    # set the categories for the filters
    @categories = Category.alpha_sorted
    
    respond_to do |format|
      # apparently order matters here
      format.json {render json: @brewery, serializer: BrewerySerializer}
      format.html {render :show}
    end

  end

  # def co_brew
  #   @breweries = Brewery.by_colorado
  # end

  # def new
  #   @brewery = Brewery.new
  #   render :new, layout: false
  # end

  def create
    @brewery = Brewery.new(brewery_params)
    # binding.pry
    if @brewery.save
      render json: @brewery, status: 201
    else
      render json: @brewery, status: 400
    end
  end

  private

  def brewery_params
    params.require(:brewery).permit(:name, :location, :description)
  end
end
