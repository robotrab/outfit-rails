class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :favorites
      t.text :message
      t.integer :image_id

      t.timestamps
    end
  end
end
