class BeersController < ApplicationController
  def show
    @beer = Beer.find_by(id: params[:id])
  end

  def new
    @beer = Beer.new
  end

  def create
    binding.pry
    # consolidate this to be find or create the beer
    if @beer = Beer.find_by(name: params[:beer][:name])
      current_user.beers << @beer
      redirect_to user_path(current_user)
    else
    #create a new beer in the database along with brewery and category and add to user
      @beer = Beer.new(beer_params)
      binding.pry
      if @beer.save
        current_user.beers << @beer
        # this is giving a validation error that the brewery must exist
        # maybe change the custom setter to use where(name == name).first_or_create
        redirect_to user_path(current_user)
      else
        render :new
      end
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :abv, :description, :brewery_name, :category_name)
  end
end
