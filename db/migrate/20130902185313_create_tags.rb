class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :content
      t.decimal :x_loc
      t.decimal :y_loc

      t.timestamps
    end
  end
end
