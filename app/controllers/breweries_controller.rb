class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.alpha_sorted

    render json: @breweries
    # respond_to do |format|
    #   # apparently order matters here
    #   format.json {render json: @breweries}
    #   format.html {render :index}
    # end
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
    # there are 3 separate calls here when you click on a brewery from the brewery list
    # binding.pry
    render json: @beers
    # respond_to do |format|
    #   # apparently order matters here
    #   format.json {render json: @beers}
    #   format.html {render :show}
    # end

  end

  def co_brew
    @breweries = Brewery.by_colorado
  end

end
