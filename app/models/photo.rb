class Photo < ActiveRecord::Base
  attr_accessible :comment_id, :gallery_id, :photographer_id, :style_id, :photo
  # a file uploader is asosciated with the Photo model
  mount_uploader :photo, PhotoUploader
  
  after_commit :delete_photo_cache
  
  has_many :galleries
  has_many :comments
  has_many :styles
  belongs_to :photographer
  
  
  def self.cached_photo(id)
    Rails.cache.fetch([Photo, id]) { find(id) }
  end

  def self.cached_photos
    Rails.cache.fetch(["Photos_index", self.all]) {self.all}
  end
  
  def delete_photo_cache
    Rails.cache.delete([Photo, self.id])
    Rails.cache.delete(["Photos_index", self.all])
  end

end
