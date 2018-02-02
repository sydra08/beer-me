class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.alpha_sorted
  end

  def show
    @brewery = Brewery.find_by(id: params[:id])

    # set the categories for the filters
    @categories = Category.alpha_sorted
    if !params[:category].blank?
      # was a filter selected?
      @beers = @brewery.by_category(params[:category])
    else
      @beers = @brewery.beers
    end
  end

  def co_brew
    @breweries = Brewery.by_colorado
  end

end
