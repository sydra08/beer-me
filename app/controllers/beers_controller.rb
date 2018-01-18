class BeersController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    # set for filters
    @categories = Category.alpha_sorted
    @breweries = Brewery.alpha_sorted

    if !params[:category].blank? && !params[:brewery].blank?
      @beers = Beer.by_category_and_brewery(params[:category], params[:brewery])
    elsif !params[:category].blank?
      @beers = Beer.by_category(params[:category])
    elsif !params[:brewery].blank?
      @beers = Beer.by_brewery(params[:brewery])
    else
      @beers = Beer.all
    end
  end

  def show
    @beer = Beer.find_by(id: params[:id])
  end

  def new
    @user = current_user
    @beer = Beer.new
    @beer.build_brewery
    @beer.build_category
    @beer.user_beers.build
  end

  def create
    @beer = Beer.find_or_create_by(name: params[:beer][:name])
    # check if an object is new or not - if it's a new object it can't already be on the user's list
    if @beer.new_record?
      # if it's new, add the details
      if @beer.update(beer_params)
        # need to figure out how to deal with the errors that could show up
          @userbeer = current_user.user_beers.create(beer_id: @beer.id, status: params[:beer][:user_beer][:status])
          redirect_to user_user_beer_path(current_user, @userbeer)
      else
        render :new
      end
    elsif !@beer.new_record?
      # does the user already have the beer on their list?
      if current_user.user_beers.find_by(beer_id: @beer)
        redirect_to new_user_beer_path, notice: "#{params[:beer][:name]} is already on your list"
      else
        binding.pry
        @userbeer = current_user.user_beers.create(beer_id: @beer.id, status: params[:beer][:user_beer][:status])
        redirect_to user_user_beer_path(current_user, @userbeer)
        # if it's not new then just create the userbeer, but now it lets you create another record for a beer that you already have, need to add another conditional
      end
    # else
    #   render :new
    end
  end

  def edit
  end

  def update
    render :new, notice: "Error: You don't have permission to do that"
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :abv, :description, brewery_attributes: [:name, :location], category_attributes: [:name])
  end
end
