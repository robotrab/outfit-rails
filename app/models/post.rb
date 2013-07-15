class Post < ActiveRecord::Base
    default_scope order: 'created_at DESC'
    belongs_to :user
    validates :message, length: { maximum: 140 }
end
