class AddAttachmentOutfitToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :outfit
    end
  end

  def self.down
    drop_attached_file :posts, :outfit
  end
end
