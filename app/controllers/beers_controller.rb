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
    respond_to do |format|
      format.json {render json: @beers}
      format.html {render :index}
    end
  end

  def show
    @beer = Beer.find_by(id: params[:id])
    respond_to do |format|
      format.json {render json: @beer}
      format.html {render :show}
    end
  end

  def new
    @user = current_user
    @beer = Beer.new
    @beer.build_brewery
    @beer.build_category
    @beer.user_beers.build
  end

  def create
    binding.pry
    @beer = Beer.find_or_create_by(name: params[:beer][:name])
    # check if an object is new or not - if it's a new object it can't already be on the user's list
    if @beer.new_record?
      # if it's new, add the details
      if @beer.update(beer_params)
          @userbeer = current_user.create_userbeer(@beer, params[:beer][:user_beer][:status])
          redirect_to user_user_beer_path(current_user, @userbeer)
      else
        render :new
      end
    elsif !@beer.new_record?
      # does the user already have the beer on their list?
      if current_user.user_beers.find_by(beer_id: @beer)
        redirect_to new_user_beer_path, notice: "#{params[:beer][:name]} is already on your list"
      else
        @userbeer = current_user.create_userbeer(@beer, params[:beer][:user_beer][:status])
        redirect_to user_user_beer_path(current_user, @userbeer)
      end
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :abv, :description, brewery_attributes: [:name, :location], category_attributes: [:name])
  end
end
