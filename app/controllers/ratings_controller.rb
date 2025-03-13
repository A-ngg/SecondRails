class RatingsController < ApplicationController
  before_action :authenticate_user! # Ensure only logged-in users can rate

    def rate
      @restaurant = Restaurant.find(params[:book_id])
      rating = params[:rating].to_i

      @rating = @restaurant.ratings.find_or_initialize_by(user: current_user)
      @rating.stars = rating

      if @rating.save
        @restaurant.update_average_rating!
        render json: { average: @restaurant.average_rating }
      else
        render json: { error: "Could not save rating" }, status: :unprocessable_entity
      end
    end
end
