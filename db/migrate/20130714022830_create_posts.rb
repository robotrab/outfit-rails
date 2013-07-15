class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user
      t.integer :favorites
      t.text :message

      t.timestamps
    end
  end
end
