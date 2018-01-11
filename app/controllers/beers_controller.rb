class BeersController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    # set for filters
    @categories = Category.alpha_sorted
    @breweries = Brewery.alpha_sorted
    # this is for the nested route
    # do we need to create a userbeer?
      # for regular index page
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
    binding.pry
    @beer = Beer.find_or_create_by(name: params[:beer][:name])
    # binding.pry
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
        @userbeer = current_user.user_beers.create(beer_id: @beer.id, status: params[:beer][:user_beer][:status])
        redirect_to user_user_beer_path(current_user, @userbeer)
        # if it's not new then just create the userbeer, but now it lets you create another record for a beer that you already have, need to add another conditional
      end
    # else
    #   render :new
    end
    # need to assign the creator_ids here as well
    # when you create a beer you are always assigning it to the user
    # need to work on adding beer notes and/or status
  end
      # this successfully creates a user_beer, but what happens if a user tries to add a beer that they already have in their collection?
      # note - when a user adds a beer the default status is want to try, should probably reflect that in the UI
      # add in a conditional for what happens if they select a beer that's already in their collection
        # if in collection => then show message "Beer is already on your list"
        # if not in collection => create userbeer object


  def edit
  end

  def update
    raise params.inspect
    render :new, notice: "Error: Invalid email address or password"
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :abv, :description, brewery_attributes: [:name, :location], category_attributes: [:name])
  end
end
