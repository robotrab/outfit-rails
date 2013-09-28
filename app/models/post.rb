class Post < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  Paperclip.interpolates :user_id do |attachment, style|
    attachment.instance.user_id
  end
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :processing
  default_scope order: 'posts.created_at DESC'
  has_attached_file :outfit,
    styles: { :profile => "profile", :mobile => "mobile" },
    processors: [:cropper],
    default_style: :profile,
    hash_secret: "testinglongSecretString",
    url: "/system/:attachment/:user_id/:style/:hash.:extension",
    path: ":rails_root/public/system/:attachment/:user_id/:style/:hash.:extension"
  belongs_to :user
  has_many :favorite_posts # Relationship
  has_many :favorited_by, through: :favorite_posts, source: :user # Actual users favoriting post
  has_many :comments, dependent: :destroy
  has_many :outfit_tags, dependent: :destroy
  validates :message, length: { maximum: 140 }
  validates_attachment :outfit, presence: true,
    :content_type => { :content_type => /image/ },
    :size => { :in => 0..6.megabytes }
  before_update :reprocess_outfit, :if => :cropping?
  before_validation :process_hashtags
  accepts_nested_attributes_for :outfit_tags, reject_if: lambda { |a| a[:content].blank? },
    allow_destroy: true
  acts_as_taggable

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def image_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(outfit.path(style))
  end

  def self.search(params)
    tire.search(load: true) do
      query { string params[:q], default_operator: "AND" } if params[:q].present?
    end
  end

  private

  def reprocess_outfit
    self.outfit.assign(outfit)
    self.outfit.save
  end

  def process_hashtags
    #self.tag_list.add(Twitter::Extractor.extract_hashtags(self.tags.content))
    self.tag_list.add(Twitter::Extractor.extract_hashtags(self.message))
  end

end
