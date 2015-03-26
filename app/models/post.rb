class Post < ActiveRecord::Base
  attr_accessor :image_cache
  default_scope { order created_at: :desc }
  mount_uploader :image, PostUploader
  validates :title, presence: true
  validates :content, presence: true
end
