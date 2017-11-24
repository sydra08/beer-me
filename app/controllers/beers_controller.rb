class BeersController < ApplicationController
  def show
    @beer = Beer.find_by(id: params[:id])
  end

  def new
    @beer = Beer.new
  end

  def create
    binding.pry
    # if you don't type in the name exactly then the match doesn't come up. maybe use autocomplete here too?
    if beer = Beer.find_by(name: params[:beer][:name])
      current_user.beers << beer
      redirect_to user_path(current_user)
    else
    #create a new beer in the database along with brewery and category (does not associate beer with user yet)
      @beer = Beer.new(beer_params)
      binding.pry
      if @beer.save
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
