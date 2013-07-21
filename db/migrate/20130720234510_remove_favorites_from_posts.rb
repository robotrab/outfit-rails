class RemoveFavoritesFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :favorites, :integer
  end
end
