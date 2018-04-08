class UserBeersController < ApplicationController
  def index
    @categories = Category.alpha_sorted
    @breweries = Brewery.alpha_sorted

    if params[:user_id]
      # set category and brewery
      if !params[:category].blank? && !params[:brewery].blank?
        @userbeers = UserBeer.by_user_and_brewery_and_category(params[:user_id], params[:brewery], params[:category])
        # set just category
      elsif !params[:category].blank?
        @userbeers = UserBeer.by_user_and_category(params[:user_id], params[:category])
        # set just brewery
      elsif !params[:brewery].blank?
        @userbeers = UserBeer.by_user_and_brewery(params[:user_id], params[:brewery])
      else
        # find a beer that user already has in their collection
        @userbeers = UserBeer.by_user(params[:user_id])
      end
    end
    render json: @userbeers
  end

  def show
    @userbeer = UserBeer.find_by(id: params[:id])
    render json: @userbeer
  end

  def update
    @userbeer = current_user.user_beers.find_by(id: params[:id])
    if params[:user_beer][:notes] != ""
      @userbeer.update(user_beer_params)
      redirect_to user_user_beer_path(current_user, @userbeer)
    elsif params[:user_beer][:status] != ""
      @userbeer.update(user_beer_params)
      redirect_to user_user_beer_path(current_user, @userbeer)
    else
      render :show
    end
  end

  def destroy
    @userbeer = UserBeer.find_by(id: params[:id])
    if @userbeer.user_id == current_user.id
      @userbeer.destroy
      redirect_to user_user_beers_path(current_user), notice: "#{@userbeer.beer.name} successfully deleted"
    else
      redirect_to user_user_beer_path(current_user), notice: "You cannot edit someone else's beer list."
    end
  end

  private

  def user_beer_params
    params.require(:user_beer).permit(:notes, :status)
  end
end
