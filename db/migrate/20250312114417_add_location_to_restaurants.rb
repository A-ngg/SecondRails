class AddLocationToRestaurants < ActiveRecord::Migration[8.0]
  def change
    add_column :restaurants, :location, :string
  end
end
