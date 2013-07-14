class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.integer :follow_id
      t.integer :follower_id
      t.string :avatar
      t.integer :favorite_id

      t.timestamps
    end
  end
end
