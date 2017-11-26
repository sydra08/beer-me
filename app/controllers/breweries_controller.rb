class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all
  end

  def show
    @brewery = Brewery.find_by(id: params[:id])
    @categories = Category.all
    if !params[:category].blank?
      @beers = @brewery.by_category(params[:category])
    else
      @beers = @brewery.beers
    end
  end
end
