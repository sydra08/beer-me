class CategoriesController < ApplicationController
  def index
    @categories = Category.alpha_sorted
    respond_to do |format|
      # apparently order matters here
      format.json {render json: @categories}
      format.html {render :index}
    end
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
    respond_to do |format|
      # apparently order matters here
      format.json {render json: @beers}
      format.html {render :show}
    end
  end
end
