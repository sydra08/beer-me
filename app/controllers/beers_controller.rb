class BeersController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def show
    @beer = Beer.find_by(id: params[:id])
  end

  def new
    @beer = Beer.new
    @beer.build_brewery
    @beer.build_category
  end

  def create
    @beer = Beer.find_or_create_by(name: params[:beer][:name])
    if @beer.update(beer_params)
      binding.pry
      current_user.beers << @beer
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :abv, :description, brewery_attributes: [:name, :location], category_attributes: [:name])
  end
end
