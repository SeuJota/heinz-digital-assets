class Image < ActiveRecord::Base
 has_attached_file :avatar, styles: { medium: "600x600>", thumb: "100x100>" }
       belongs_to :category
	validates :name,  presence: true

  # Validate the attached image is image/jpg, image/png, etc
  #validates_attachment :avatar, :content_type => { :content_type => ["image/jpg","image/jpeg", "image/gif", "image/png"] }
end
