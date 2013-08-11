class Post < ActiveRecord::Base
  Paperclip.interpolates :user_id do |attachment, style|
    attachment.instance.user_id
  end
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  default_scope order: 'posts.created_at DESC'
  has_attached_file :outfit,
    styles: { :profile => "364x646>", :mobile => "256x455>"},
    default_style: :profile,
    hash_secret: "testinglongSecretString",
    url: "/system/:attachment/:user_id/:style/:hash.:extension",
    path: ":rails_root/public/system/:attachment/:user_id/:style/:hash.:extension",
    processors: [:cropper]
  belongs_to :user
  has_many :favorite_posts # Relationship
  has_many :favorited_by, through: :favorite_posts, source: :user # Actual users favoriting post
  validates :message, length: { maximum: 140 }
  validates_attachment :outfit, presence: true,
    :content_type => { :content_type => /image/ },
    :size => { :in => 0..6.megabytes }
  after_save :process_outfit, :if => :cropping?

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  private

  def process_outfit
    outfit.reprocess!
  end
end
