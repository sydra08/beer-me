class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all
    @categories = Category.all
  end

  def show
    @brewery = Brewery.find_by(id: params[:id])
  end
end
