class CategoriesController < ApplicationController
  def index
    @categories = Category.alpha_sorted
  end

  def show
    @category = Category.find_by(id: params[:id])

    # set the breweries for the filters
    @breweries = Brewery.alpha_sorted
    if !params[:brewery].blank?
      # was a filter selected?
      @beers = @category.by_brewery(params[:brewery])
    else
      @beers = @category.beers
    end
  end
end
