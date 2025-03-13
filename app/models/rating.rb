class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :stars, presence: true, inclusion: { in: 1..5 }
end
