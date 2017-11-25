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
    # consolidate this to be find or create the beer
    if @beer = Beer.find_by(name: params[:beer][:name])
      binding.pry
      current_user.beers << @beer
      redirect_to user_path(current_user)
    else
    #create a new beer in the database along with brewery and category and add to user
      binding.pry
      @beer = Beer.new(beer_params)
      if @beer.save
        binding.pry

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
    # i think there's an error here where it's looking for the brewery/category id instead forming the association via object
    params.require(:beer).permit(:name, :abv, :description, brewery_attributes: [:name, :location], category_attributes: [:name])
  end
end
