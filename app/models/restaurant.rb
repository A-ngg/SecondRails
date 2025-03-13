class Restaurant < ApplicationRecord
    has_many :ratings, dependent: :destroy

    def average_rating
      ratings.average(:stars).to_f.round(1) || 0
    end

    def update_average_rating!
        self.average_rating = ratings.average(:value).to_f
        save!
    end
end
