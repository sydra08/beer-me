class BeersController < ApplicationController
  def show
    @beer = Beer.find_by(id: params[:id])
  end

  def new
    @beer = Beer.new
  end

  def create
    #create a new beer in the database (does not associate beer with user yet)
    @beer = Beer.new(beer_params)
    @beer.brewery = Brewery.find_by(id: params[:beer][:brewery])
    @beer.category = Category.find_by(id: params[:beer][:category])
    if @beer.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :abv, :description)
  end
end
