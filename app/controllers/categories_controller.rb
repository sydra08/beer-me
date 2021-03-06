class CategoriesController < ApplicationController
  def index
    @categories = Category.alpha_sorted
    respond_to do |format|
      # apparently order matters here
      format.json {render json: @categories, each_serializer: CategorySerializer}
      format.html {render :index}
    end
  end

  def show
    @category = Category.find_by(id: params[:id])

    # set the breweries for the filters
    @breweries = Brewery.alpha_sorted

    respond_to do |format|
      # apparently order matters here
      format.json {render json: @category, serializer: CategorySerializer}
      format.html {render :show}
    end
  end
end
