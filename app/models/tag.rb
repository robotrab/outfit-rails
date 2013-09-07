class Tag < ActiveRecord::Base
    #has_many :taggings
    #has_many :posts, through: :taggings
    belongs_to :post
end
