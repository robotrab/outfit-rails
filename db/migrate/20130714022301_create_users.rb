class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.index :username
      t.string :name
      t.string :password_digest
      t.string :email
      t.references :follow
      t.references :follower
      t.string :avatar_url
      t.references :favorite

      t.timestamps
    end
  end
end
