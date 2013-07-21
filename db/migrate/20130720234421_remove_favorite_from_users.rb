class RemoveFavoriteFromUsers < ActiveRecord::Migration
  def change
    remove_reference :users, :favorite, index: true
  end
end
