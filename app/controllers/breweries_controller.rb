class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all
  end

  def show
    @brewery = Brewery.find_by(id: params[:id])

    # set the categories for the filters
    @categories = Category.all
    if !params[:category].blank?
      # was a filter selected?
      @beers = @brewery.by_category(params[:category])
    else
      @beers = @brewery.beers
    end
  end
end
