class CreateTags < ActiveRecord::Migration
  def change
    create_table :outfit_tags do |t|
      t.string :content
      t.decimal :x_loc
      t.decimal :y_loc
      t.belongs_to :post, index: true
      t.timestamps
    end
  end
end
