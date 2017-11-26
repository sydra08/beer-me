class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(id: params[:id])
    @breweries = Brewery.all
    if !params[:brewery].blank?
      @beers = @category.by_brewery(params[:brewery])
    else
      @beers = @category.beers
    end
  end
end
