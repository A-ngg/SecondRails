class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [ :rate ]

  def rate
    @restaurant = Restaurant.find(params[:id])
    rating = @restaurant.ratings.find_or_initialize_by(user: current_user)

    if params[:rating].present?
      rating.stars = params[:rating].to_i
    else
      return render json: { error: "Invalid rating value" }, status: :unprocessable_entity
    end

    if rating.save
      render json: { average: @restaurant.average_rating }
    else
      render json: { error: rating.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end
  def show
  @restaurant = Restaurant.find_by(id: params[:id])

  if @restaurant.nil?
    flash[:alert] = "Restaurant not found."
    redirect_to restaurants_path
  end
end
def index
  @restaurants = Restaurant.all
end
end
