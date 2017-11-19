class BeersController < ApplicationController
  def show
    @beer = Beer.find_by(id: params[:id])
  end
end
