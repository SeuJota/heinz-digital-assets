class Image < ActiveRecord::Base
 has_attached_file :avatar
 belongs_to :category

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
