class Post < ActiveRecord::Base
    default_scope order: 'posts.created_at DESC'
    has_attached_file :outfit,
      :url => "/system/:attachment/:id/:style/:basename.:extension",
      :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension"
    belongs_to :user
    has_many :favorite_posts # Relationship
    has_many :favorited_by, through: :favorite_posts, source: :user # Actual users favoriting post
    validates :message, length: { maximum: 140 }
end
