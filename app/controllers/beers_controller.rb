class BeersController < ApplicationController
  def show
    @beer = Beer.find_by(id: params[:id])
  end

  def new
    @beer = Beer.new
  end

  def create
    #create a new beer in the database along with brewery and category (does not associate beer with user yet)
    @beer = Beer.new(beer_params)
    binding.pry
    if @beer.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :abv, :description, :brewery_name, :category_name)
  end
end
